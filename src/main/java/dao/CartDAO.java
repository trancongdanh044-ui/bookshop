package dao;

import java.sql.*;
import java.util.*;
import model.Book;
import model.Cart;
import model.CartItem;
import util.DBConnection;

public class CartDAO {

    // lấy cart theo user
    public Cart getCartByUser(int userId) {
        String sql = "SELECT * FROM Cart WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setItems(getCartItems(cart.getId()));
                return cart;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // lấy item trong cart
    public List<CartItem> getCartItems(int cartId) {
        List<CartItem> list = new ArrayList<>();

        String sql = " SELECT ci.*, b.title, b.price "
                + "FROM CartItem ci JOIN Book b "
                + "ON ci.book_id = b.id  "
                + "WHERE ci.cart_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Book b = new Book();
                b.setId(rs.getInt("book_id"));
                b.setTitle(rs.getString("title"));
                b.setPrice(rs.getDouble("price"));

                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setBook(b);
                item.setQuantity(rs.getInt("quantity"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // thêm vào cart
    public void addToCart(int cartId, int bookId, int quantity) {
        String checkSql = "SELECT * FROM CartItem WHERE cart_id=? AND book_id=?";
        String insertSql = "INSERT INTO CartItem(cart_id, book_id, quantity) VALUES(?,?,?)";
        String updateSql = "UPDATE CartItem SET quantity = quantity + ? WHERE cart_id=? AND book_id=?";

        try (Connection conn = DBConnection.getConnection()) {

            PreparedStatement check = conn.prepareStatement(checkSql);
            check.setInt(1, cartId);
            check.setInt(2, bookId);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                PreparedStatement update = conn.prepareStatement(updateSql);
                update.setInt(1, quantity);
                update.setInt(2, cartId);
                update.setInt(3, bookId);
                update.executeUpdate();
            } else {
                PreparedStatement insert = conn.prepareStatement(insertSql);
                insert.setInt(1, cartId);
                insert.setInt(2, bookId);
                insert.setInt(3, quantity);
                insert.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // xóa item
    public void removeItem(int cartItemId) {
        String sql = "DELETE FROM CartItem WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartItemId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}