package controller;

import dao.BookDAO;
import dao.ReviewDAO;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import model.Review;
import model.User;
import model.Category;

@WebServlet(name = "BookController", urlPatterns = {"/BookController"})
public class BookController extends HttpServlet {

    private static final int ITEMS_PER_PAGE = 12;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        BookDAO bookDAO = new BookDAO();

        if ("detail".equals(action)) {
            showDetail(req, res, bookDAO);
            return;
        }
        
         String categoryIdParam = req.getParameter("categoryId");
        
        String keyword = trimToNull(req.getParameter("search"));
        List<Book> books ;
        
         if (categoryIdParam != null && !categoryIdParam.isEmpty() && keyword != null) {
            // CÓ cả category VÀ search -> tìm trong category đó
            int categoryId = Integer.parseInt(categoryIdParam);
            books = bookDAO.searchByKeywordAndCategory(keyword, categoryId);
        } 
        else if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
            // CHỈ CÓ category, KHÔNG có search -> lọc theo category
            int categoryId = Integer.parseInt(categoryIdParam);
            books = bookDAO.getByCategory(categoryId);
        } 
        else if (keyword != null) {
            // CHỈ CÓ search, KHÔNG có category -> tìm toàn bộ
            books = bookDAO.search(keyword);
        } 
        else {
            // KHÔNG có filter gì -> lấy tất cả
            books = bookDAO.getAll();
        }

        int page = parsePositiveInt(req.getParameter("page"), 1);
        int totalBooks = books.size();
        int totalPages = Math.max(1, (int) Math.ceil((double) totalBooks / ITEMS_PER_PAGE));
        if (page > totalPages) {
            page = totalPages;
        }

        int startIndex = Math.max(0, (page - 1) * ITEMS_PER_PAGE);
        int endIndex = Math.min(startIndex + ITEMS_PER_PAGE, totalBooks);
        List<Book> pageBooks = totalBooks == 0 ? Collections.emptyList() : books.subList(startIndex, endIndex);

        List<Category> categories=bookDAO.getAllCategories();
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCategory", categoryIdParam);
        req.setAttribute("books", pageBooks);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("search", keyword == null ? "" : keyword);
        req.setAttribute("totalBooks", totalBooks);
        req.getRequestDispatcher("/view/customer/books-list.jsp").forward(req, res);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse res, BookDAO bookDAO)
            throws IOException, ServletException {
        int bookId = parsePositiveInt(req.getParameter("bookId"), -1);
        if (bookId <= 0) {
            res.sendRedirect("BookController");
            return;
        }

        Book book = bookDAO.getById(bookId);
        if (book == null) {
            res.sendRedirect("BookController");
            return;
        }

        ReviewDAO reviewDAO = new ReviewDAO();
        List<Review> reviews = reviewDAO.getByBook(bookId);
        User user = (User) req.getSession().getAttribute("user");

        req.setAttribute("book", book);
        req.setAttribute("reviews", reviews);
        req.setAttribute("reviewCount", reviews.size());
        req.setAttribute("canReview", user != null && reviewDAO.hasPurchasedBook(user.getId(), bookId) && !reviewDAO.hasReviewed(user.getId(), bookId));
        req.setAttribute("reviewError", req.getSession().getAttribute("reviewError"));
        req.setAttribute("reviewSuccess", req.getSession().getAttribute("reviewSuccess"));
        req.getSession().removeAttribute("reviewError");
        req.getSession().removeAttribute("reviewSuccess");
        req.getRequestDispatcher("/view/user/book-detail.jsp").forward(req, res);
    }

    private int parsePositiveInt(String value, int defaultValue) {
        try {
            int parsed = Integer.parseInt(value);
            return parsed > 0 ? parsed : defaultValue;
        } catch (Exception ex) {
            return defaultValue;
        }
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
