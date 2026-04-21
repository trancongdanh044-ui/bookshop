package controller;

import dao.BookDAO;
import dao.OrderDetailDAO;
import dao.OrdersDAO;
import dao.VoucherDAO;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Book;
import model.CartItem;
import model.OrderDetail;
import model.Orders;
import model.User;
import model.Voucher;
import util.DBConnection;

@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        if ("checkout".equals(action)) {
            List<CartItem> cart = getCart(session);
            if (cart.isEmpty()) {
                session.setAttribute("flashError", "Giỏ hàng đang trống.");
                res.sendRedirect("CartController");
                return;
            }

            req.getRequestDispatcher("/view/customer/checkout.jsp").forward(req, res);
            return;
        }

        if ("history".equals(action)) {
            OrdersDAO ordersDAO = new OrdersDAO();
            User user = (User) session.getAttribute("user");
            List<Orders> orders = user != null && user.getId() > 0
                    ? ordersDAO.getOrdersByUser(user.getId())
                    : ordersDAO.getOrdersByIds(getGuestOrderIds(session));

            req.setAttribute("orders", orders);
            req.getRequestDispatcher("/view/customer/order-history.jsp").forward(req, res);
            return;
        }

        res.sendRedirect("BookController");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        List<CartItem> cart = getCart(session);

        if (cart.isEmpty()) {
            session.setAttribute("flashError", "Giỏ hàng đang trống.");
            res.sendRedirect("CartController");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        String recipientName = trimToEmpty(req.getParameter("fullName"));
        String recipientEmail = trimToEmpty(req.getParameter("email"));
        String shippingAddress = trimToEmpty(req.getParameter("shippingAddress"));
        String shippingPhone = trimToEmpty(req.getParameter("shippingPhone"));
        String paymentMethod = trimToEmpty(req.getParameter("paymentMethod"));
        String voucherCode = trimToEmpty(req.getParameter("voucherCode"));

        if (recipientName.isEmpty() && sessionUser != null) {
            recipientName = trimToEmpty(sessionUser.getFullName());
        }
        if (recipientEmail.isEmpty() && sessionUser != null) {
            recipientEmail = trimToEmpty(sessionUser.getEmail());
        }
        if (shippingAddress.isEmpty() && sessionUser != null) {
            shippingAddress = trimToEmpty(sessionUser.getAddress());
        }
        if (shippingPhone.isEmpty() && sessionUser != null) {
            shippingPhone = trimToEmpty(sessionUser.getPhone());
        }

        if (recipientName.isEmpty() || shippingAddress.isEmpty() || shippingPhone.isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ họ tên, số điện thoại và địa chỉ nhận hàng.");
            req.getRequestDispatcher("/view/customer/checkout.jsp").forward(req, res);
            return;
        }

        if (paymentMethod.isEmpty()) {
            paymentMethod = "cod";
        }

        double originalTotal = 0;
        for (CartItem item : cart) {
            originalTotal += item.getBook().getFinalPrice() * item.getQuantity();
        }

        VoucherDAO voucherDAO = new VoucherDAO();
        Voucher voucher = null;
        double discountAmount = 0;
        if (!voucherCode.isEmpty()) {
            voucher = voucherDAO.getByCode(voucherCode);
            if (voucher == null || !voucherDAO.isActive(voucher) || originalTotal < voucher.getMinOrderValue()) {
                req.setAttribute("error", "Voucher không hợp lệ hoặc chưa đủ điều kiện áp dụng.");
                req.getRequestDispatcher("/view/customer/checkout.jsp").forward(req, res);
                return;
            }

            if ("percent".equalsIgnoreCase(voucher.getType())) {
                discountAmount = originalTotal * voucher.getDiscount() / 100.0;
            } else {
                discountAmount = voucher.getDiscount();
            }
            if (discountAmount > originalTotal) {
                discountAmount = originalTotal;
            }
        }

        Orders order = new Orders();
        order.setUser(sessionUser);
        order.setOrderDate(new Date());
        order.setOriginalTotal(originalTotal);
        order.setDiscountAmount(discountAmount);
        order.setTotalPrice(originalTotal - discountAmount);
        order.setStatus("Chờ xác nhận");
        order.setShippingAddress(shippingAddress);
        order.setShippingPhone(shippingPhone);
        order.setPaymentMethod(paymentMethod);
        order.setRecipientName(recipientName);
        order.setRecipientEmail(recipientEmail);
        order.setVoucher(voucher);

        OrdersDAO ordersDAO = new OrdersDAO();
        BookDAO bookDAO = new BookDAO();
        OrderDetailDAO detailDAO = new OrderDetailDAO();
        int orderId = -1;

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            if (voucher != null && !voucherDAO.reduceQuantity(conn, voucher.getId())) {
                conn.rollback();
                req.setAttribute("error", "Voucher đã hết lượt sử dụng.");
                req.getRequestDispatcher("/view/customer/checkout.jsp").forward(req, res);
                return;
            }

            orderId = ordersDAO.insert(conn, order);
            if (orderId <= 0) {
                conn.rollback();
                req.setAttribute("error", "Không thể tạo đơn hàng. Vui lòng thử lại.");
                req.getRequestDispatcher("/view/customer/checkout.jsp").forward(req, res);
                return;
            }

            for (CartItem item : cart) {
                if (!bookDAO.reduceQuantity(conn, item.getBook().getId(), item.getQuantity())) {
                    conn.rollback();
                    req.setAttribute("error", "Một hoặc nhiều sản phẩm đã hết hàng trong lúc thanh toán. Vui lòng kiểm tra lại giỏ hàng.");
                    req.getRequestDispatcher("/view/customer/checkout.jsp").forward(req, res);
                    return;
                }

                OrderDetail detail = new OrderDetail();
                detail.setOrderId(orderId);
                detail.setBook(item.getBook());
                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getBook().getFinalPrice());
                detailDAO.insert(conn, detail);
            }

            conn.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            req.setAttribute("error", "Thanh toán thất bại. Vui lòng thử lại.");
            req.getRequestDispatcher("/view/customer/checkout.jsp").forward(req, res);
            return;
        }

        if (sessionUser == null) {
            List<Integer> guestOrderIds = getGuestOrderIds(session);
            guestOrderIds.add(orderId);
            session.setAttribute("guestOrderIds", guestOrderIds);
        }

        session.removeAttribute("cart");
        session.setAttribute("cartCount", 0);
        session.setAttribute("cartTotal", 0.0);

        req.setAttribute("orderId", orderId);
        req.setAttribute("orderTotal", order.getTotalPrice());
        req.setAttribute("paymentMethod", paymentMethod);
        req.setAttribute("recipientName", recipientName);
        req.setAttribute("recipientEmail", recipientEmail);
        req.setAttribute("discountAmount", discountAmount);
        req.getRequestDispatcher("/view/customer/order-success.jsp").forward(req, res);
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        return cart == null ? new ArrayList<CartItem>() : cart;
    }

    @SuppressWarnings("unchecked")
    private List<Integer> getGuestOrderIds(HttpSession session) {
        List<Integer> guestOrderIds = (List<Integer>) session.getAttribute("guestOrderIds");
        if (guestOrderIds == null) {
            guestOrderIds = new ArrayList<>();
            session.setAttribute("guestOrderIds", guestOrderIds);
        }
        return guestOrderIds;
    }

    private String trimToEmpty(String value) {
        return value == null ? "" : value.trim();
    }
}
