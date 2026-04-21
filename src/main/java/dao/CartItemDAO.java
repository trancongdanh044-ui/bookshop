package dao;

import java.sql.*;
import java.util.*;
import model.Book;
import model.CartItem;
import util.DBConnection;

public class CartItemDAO {

    // lấy tất cả item theo cart_id
    public List<CartItem> getByCartId(int cartId) {
        List<CartItem> list = new ArrayList<>();

        String sql = "SELECT ci.*, b.title, b.price FROM CartItem ci "
                + "JOIN Book b ON ci.book_id = b.id "
                + "WHERE ci.cart_id = ?;";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setPrice(rs.getDouble("price"));

                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setBook(book);
                item.setQuantity(rs.getInt("quantity"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // tìm item theo cart + book
    public CartItem findByCartAndBook(int cartId, int bookId) {
        String sql = "SELECT * FROM CartItem WHERE cart_id=? AND book_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, bookId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setQuantity(rs.getInt("quantity"));
                return item;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // thêm mới
    public void insert(int cartId, int bookId, int quantity) {
        String sql = "INSERT INTO CartItem(cart_id, book_id, quantity) VALUES(?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, bookId);
            ps.setInt(3, quantity);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // update số lượng
    public void updateQuantity(int id, int quantity) {
        String sql = "UPDATE CartItem SET quantity=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // tăng số lượng (+1)
    public void increase(int cartId, int bookId) {
        String sql = "UPDATE CartItem SET quantity = quantity + 1 WHERE cart_id=? AND book_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, bookId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // giảm số lượng (-1)
    public void decrease(int cartId, int bookId) {
        String sql = "UPDATE CartItem SET quantity = quantity - 1 WHERE cart_id=? AND book_id=? AND quantity > 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, bookId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // xóa item theo id
    public void delete(int id) {
        String sql = "DELETE FROM CartItem WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // xóa theo cart + book
    public void deleteByCartAndBook(int cartId, int bookId) {
        String sql = "DELETE FROM CartItem WHERE cart_id=? AND book_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, bookId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}