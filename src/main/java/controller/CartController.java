package controller;

import dao.BookDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Book;
import model.CartItem;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        List<CartItem> cart = getCart(session);

        if ("add".equals(action)) {
            handleAddToCart(req, cart);
            updateCartSummary(session, cart);
            if ("1".equals(req.getParameter("buyNow"))) {
                res.sendRedirect("OrderController?action=checkout");
            } else {
                res.sendRedirect("BookController");
            }
            return;
        }

        if ("remove".equals(action)) {
            handleRemoveFromCart(req, cart);
            updateCartSummary(session, cart);
            res.sendRedirect("CartController");
            return;
        }

        if ("update".equals(action)) {
            handleUpdateQuantity(req, cart);
            updateCartSummary(session, cart);
            res.sendRedirect("CartController");
            return;
        }

        if ("clear".equals(action)) {
            cart.clear();
            updateCartSummary(session, cart);
            res.sendRedirect("CartController");
            return;
        }

        updateCartSummary(session, cart);
        req.getRequestDispatcher("/view/customer/cart.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        doGet(req, res);
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void handleAddToCart(HttpServletRequest req, List<CartItem> cart) {
        int bookId = parsePositiveInt(req.getParameter("id"), -1);
        int quantity = parsePositiveInt(req.getParameter("quantity"), 1);
        if (bookId <= 0 || quantity <= 0) {
            return;
        }

        Book book = new BookDAO().getById(bookId);
        if (book == null || book.getQuantity() <= 0) {
            return;
        }

        for (CartItem item : cart) {
            if (item.getBook().getId() == bookId) {
                item.setQuantity(Math.min(item.getQuantity() + quantity, book.getQuantity()));
                return;
            }
        }

        cart.add(new CartItem(0, book, Math.min(quantity, book.getQuantity())));
    }

    private void handleRemoveFromCart(HttpServletRequest req, List<CartItem> cart) {
        int bookId = parsePositiveInt(req.getParameter("id"), -1);
        if (bookId <= 0) {
            return;
        }

        cart.removeIf(item -> item.getBook().getId() == bookId);
    }

    private void handleUpdateQuantity(HttpServletRequest req, List<CartItem> cart) {
        int bookId = parsePositiveInt(req.getParameter("id"), -1);
        int quantity = parsePositiveInt(req.getParameter("quantity"), 1);
        if (bookId <= 0) {
            return;
        }

        Iterator<CartItem> iterator = cart.iterator();
        while (iterator.hasNext()) {
            CartItem item = iterator.next();
            if (item.getBook().getId() == bookId) {
                if (quantity <= 0) {
                    iterator.remove();
                } else {
                    item.setQuantity(Math.min(quantity, item.getBook().getQuantity()));
                }
                return;
            }
        }
    }

    private void updateCartSummary(HttpSession session, List<CartItem> cart) {
        double totalPrice = 0;
        int totalItems = 0;

        for (CartItem item : cart) {
            totalPrice += item.getBook().getFinalPrice() * item.getQuantity();
            totalItems += item.getQuantity();
        }

        session.setAttribute("cart", cart);
        session.setAttribute("cartCount", totalItems);
        session.setAttribute("cartTotal", totalPrice);
    }

    private int parsePositiveInt(String value, int defaultValue) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed >= 0 ? parsed : defaultValue;
        } catch (Exception ex) {
            return defaultValue;
        }
    }
}
