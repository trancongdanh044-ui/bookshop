package controller;

import dao.BookDAO;
import dao.CategoryDAO;
import dao.OrdersDAO;
import dao.VoucherDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Book;
import model.Category;
import model.Orders;
import model.User;
import model.Voucher;
import util.DBConnection;

@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = getAdminUser(req.getSession());
        if (user == null) {
            res.sendRedirect("AuthController?action=login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null || "dashboard".equals(action)) {
            loadDashboard(req);
            req.getRequestDispatcher("/view/admin/dashboard.jsp").forward(req, res);
            return;
        }

        BookDAO bookDAO = new BookDAO();
        OrdersDAO ordersDAO = new OrdersDAO();
        VoucherDAO voucherDAO = new VoucherDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        switch (action) {
            case "manageBooks":
                req.setAttribute("books", bookDAO.getAll());
                moveSessionMessage(req.getSession(), req, "bookSuccess");
                moveSessionMessage(req.getSession(), req, "bookError");
                req.getRequestDispatcher("/view/admin/book-list.jsp").forward(req, res);
                break;
            case "addBook":
                req.setAttribute("categories", categoryDAO.getAll());
                moveSessionMessage(req.getSession(), req, "bookError");
                req.getRequestDispatcher("/view/admin/book-form.jsp").forward(req, res);
                break;
            case "editBook":
                req.setAttribute("book", bookDAO.getById(parsePositiveInt(req.getParameter("bookId"), -1)));
                req.setAttribute("categories", categoryDAO.getAll());
                moveSessionMessage(req.getSession(), req, "bookError");
                req.getRequestDispatcher("/view/admin/book-form.jsp").forward(req, res);
                break;
            case "deleteBook":
                bookDAO.delete(parsePositiveInt(req.getParameter("bookId"), -1));
                res.sendRedirect("AdminController?action=manageBooks");
                break;
            case "manageOrders":
                req.setAttribute("orders", ordersDAO.getAllOrders());
                req.getRequestDispatcher("/view/admin/order-list.jsp").forward(req, res);
                break;
            case "updateOrderStatus":
                ordersDAO.updateStatus(
                        parsePositiveInt(req.getParameter("orderId"), -1),
                        req.getParameter("status")
                );
                res.sendRedirect("AdminController?action=manageOrders");
                break;
            case "manageVouchers":
                req.setAttribute("vouchers", voucherDAO.getAllVouchers());
                req.setAttribute("today", new java.util.Date());
                req.getRequestDispatcher("/view/admin/voucher-management.jsp").forward(req, res);
                break;
            case "addVoucher":
                req.getRequestDispatcher("/view/admin/voucher-form.jsp").forward(req, res);
                break;
            case "editVoucher":
                req.setAttribute("voucher", voucherDAO.getById(parsePositiveInt(req.getParameter("voucherId"), -1)));
                req.getRequestDispatcher("/view/admin/voucher-form.jsp").forward(req, res);
                break;
            case "deleteVoucher":
                voucherDAO.delete(parsePositiveInt(req.getParameter("voucherId"), -1));
                res.sendRedirect("AdminController?action=manageVouchers");
                break;
            default:
                loadDashboard(req);
                req.getRequestDispatcher("/view/admin/dashboard.jsp").forward(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = getAdminUser(req.getSession());
        if (user == null) {
            res.sendRedirect("AuthController?action=login");
            return;
        }

        String action = req.getParameter("action");
        BookDAO bookDAO = new BookDAO();
        VoucherDAO voucherDAO = new VoucherDAO();

        try {
            if ("addBook".equals(action) || "updateBook".equals(action)) {
                Book book = new Book();
                if ("updateBook".equals(action)) {
                    book.setId(parsePositiveInt(req.getParameter("bookId"), -1));
                }

                book.setTitle(req.getParameter("title"));
                book.setAuthor(req.getParameter("author"));
                book.setPrice(parseDouble(req.getParameter("price")));
                book.setDiscount(parseDouble(req.getParameter("discount")));
                book.setQuantity(parsePositiveInt(req.getParameter("quantity"), 0));
                book.setDescription(req.getParameter("description"));
                book.setImage(req.getParameter("image"));

                int categoryId = parsePositiveInt(req.getParameter("categoryId"), 0);
                if (categoryId > 0) {
                    book.setCategory(new Category(categoryId, null));
                }

                if ("addBook".equals(action)) {
                    bookDAO.insert(book);
                    req.getSession().setAttribute("bookSuccess", "Them sach thanh cong vao " + DBConnection.getConfiguredUrl());
                } else {
                    bookDAO.update(book);
                    req.getSession().setAttribute("bookSuccess", "Cap nhat sach thanh cong trong " + DBConnection.getConfiguredUrl());
                }

                res.sendRedirect("AdminController?action=manageBooks");
                return;
            }

            if ("addVoucher".equals(action) || "updateVoucher".equals(action)) {
                Voucher voucher = new Voucher();
                if ("updateVoucher".equals(action)) {
                    voucher.setId(parsePositiveInt(req.getParameter("voucherId"), -1));
                }

                voucher.setCode(req.getParameter("code"));
                voucher.setDiscount(parseDouble(req.getParameter("discount")));
                voucher.setType(req.getParameter("type"));
                voucher.setQuantity(parsePositiveInt(req.getParameter("quantity"), 0));
                voucher.setMinOrderValue(parseDouble(req.getParameter("minOrderValue")));
                voucher.setStartDate(Date.valueOf(req.getParameter("startDate")));
                voucher.setEndDate(Date.valueOf(req.getParameter("endDate")));

                if ("addVoucher".equals(action)) {
                    voucherDAO.insert(voucher);
                } else {
                    voucherDAO.update(voucher);
                }

                res.sendRedirect("AdminController?action=manageVouchers");
                return;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            if ("addBook".equals(action) || "updateBook".equals(action)) {
                req.getSession().setAttribute("bookError", buildBookErrorMessage(action, ex));
                if ("updateBook".equals(action)) {
                    res.sendRedirect("AdminController?action=editBook&bookId=" + parsePositiveInt(req.getParameter("bookId"), -1));
                } else {
                    res.sendRedirect("AdminController?action=addBook");
                }
                return;
            }
        }

        res.sendRedirect("AdminController?action=dashboard");
    }

    private User getAdminUser(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"admin".equals(user.getRole())) {
            return null;
        }
        return user;
    }

    private void loadDashboard(HttpServletRequest req) {
        List<Book> books = new BookDAO().getAll();
        List<Orders> orders = new OrdersDAO().getAllOrders();
        List<Voucher> vouchers = new VoucherDAO().getAllVouchers();

        double revenue = 0;
        for (Orders order : orders) {
            if (!"Đã hủy".equals(order.getStatus())) {
                revenue += order.getTotalPrice();
            }
        }

        req.setAttribute("bookCount", books.size());
        req.setAttribute("orderCount", orders.size());
        req.setAttribute("voucherCount", vouchers.size());
        req.setAttribute("revenue", revenue);
        req.setAttribute("recentOrders", orders.size() > 5 ? orders.subList(0, 5) : orders);
    }

    private int parsePositiveInt(String value, int defaultValue) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed >= 0 ? parsed : defaultValue;
        } catch (Exception ex) {
            return defaultValue;
        }
    }

    private double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception ex) {
            return 0;
        }
    }

    private void moveSessionMessage(HttpSession session, HttpServletRequest req, String attributeName) {
        Object value = session.getAttribute(attributeName);
        if (value != null) {
            req.setAttribute(attributeName, value);
            session.removeAttribute(attributeName);
        }
    }

    private String buildBookErrorMessage(String action, Exception ex) {
        Throwable rootCause = ex;
        while (rootCause.getCause() != null) {
            rootCause = rootCause.getCause();
        }

        String operation = "updateBook".equals(action) ? "cap nhat" : "them";
        return "Khong the " + operation + " sach. Ung dung dang dung DB "
                + DBConnection.getConfiguredUrl()
                + ". Loi goc: " + rootCause.getMessage();
    }
}
