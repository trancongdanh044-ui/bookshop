package dao;

import java.sql.*;
import java.util.*;
import model.Review;
import model.User;
import util.DBConnection;

public class ReviewDAO {

    // thêm review
    public void addReview(Review r) {
        String sql = "INSERT INTO Review(user_id, book_id, rating, comment) VALUES(?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, r.getUser().getId());
            ps.setInt(2, r.getBook().getId());
            ps.setInt(3, r.getRating());
            ps.setString(4, r.getComment());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean hasPurchasedBook(int userId, int bookId) {
        String sql = "SELECT 1 "
                + "FROM Orders o JOIN OrderDetail od ON o.id = od.order_id "
                + "WHERE o.user_id = ? AND od.book_id = ? AND o.status = 'Hoàn thành' LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean hasReviewed(int userId, int bookId) {
        String sql = "SELECT 1 FROM Review WHERE user_id = ? AND book_id = ? LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // lấy review theo book
    public List<Review> getByBook(int bookId) {
        List<Review> list = new ArrayList<>();

        String sql = "SELECT r.*, u.username "
                + "FROM Review r "
                + "JOIN User u ON r.user_id = u.id "
                + "WHERE book_id=?";
            
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));

                Review r = new Review();
                r.setId(rs.getInt("id"));
                r.setUser(u);
                r.setRating(rs.getInt("rating"));
                r.setComment(rs.getString("comment"));

                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
