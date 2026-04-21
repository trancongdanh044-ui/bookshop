package controller;

import dao.ReviewDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Book;
import model.Review;
import model.User;

@WebServlet(name = "ReviewController", urlPatterns = {"/ReviewController"})
public class ReviewController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        User user = (User) req.getSession().getAttribute("user");
        int bookId = parseInt(req.getParameter("bookId"));
        int rating = parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");

        if (bookId <= 0) {
            res.sendRedirect("BookController");
            return;
        }

        if (user == null) {
            req.getSession().setAttribute("reviewError", "Bạn cần đăng nhập để đánh giá sách.");
            res.sendRedirect("BookController?action=detail&bookId=" + bookId);
            return;
        }

        ReviewDAO reviewDAO = new ReviewDAO();
        if (!reviewDAO.hasPurchasedBook(user.getId(), bookId)) {
            req.getSession().setAttribute("reviewError", "Chỉ khách đã mua và hoàn thành đơn mới có thể đánh giá sách.");
            res.sendRedirect("BookController?action=detail&bookId=" + bookId);
            return;
        }

        if (reviewDAO.hasReviewed(user.getId(), bookId)) {
            req.getSession().setAttribute("reviewError", "Bạn đã đánh giá sách này rồi.");
            res.sendRedirect("BookController?action=detail&bookId=" + bookId);
            return;
        }

        if (rating < 1 || rating > 5) {
            req.getSession().setAttribute("reviewError", "Số sao đánh giá không hợp lệ.");
            res.sendRedirect("BookController?action=detail&bookId=" + bookId);
            return;
        }

        Review review = new Review();
        review.setUser(user);
        Book book = new Book();
        book.setId(bookId);
        review.setBook(book);
        review.setRating(rating);
        review.setComment(comment);
        reviewDAO.addReview(review);

        req.getSession().setAttribute("reviewSuccess", "Đánh giá đã được gửi.");
        res.sendRedirect("BookController?action=detail&bookId=" + bookId);
    }

    private int parseInt(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return -1;
        }
    }
}
