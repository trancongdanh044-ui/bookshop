package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Book;
import model.OrderDetail;
import model.Orders;
import model.User;
import util.DBConnection;

public class OrdersDAO {

    public List<Orders> getOrdersByUser(int userId) {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM Orders o "
                + "LEFT JOIN User u ON o.user_id = u.id "
                + "WHERE o.user_id = ? ORDER BY o.order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapOrder(rs, true));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Orders> getOrdersByIds(List<Integer> orderIds) {
        if (orderIds == null || orderIds.isEmpty()) {
            return Collections.emptyList();
        }

        List<Orders> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT o.*, u.full_name, u.email FROM Orders o "
                + "LEFT JOIN User u ON o.user_id = u.id WHERE o.id IN ("
        );

        for (int i = 0; i < orderIds.size(); i++) {
            if (i > 0) {
                sql.append(',');
            }
            sql.append('?');
        }
        sql.append(") ORDER BY o.order_date DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < orderIds.size(); i++) {
                ps.setInt(i + 1, orderIds.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapOrder(rs, true));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Orders> getAllOrders() {
        List<Orders> list = new ArrayList<>();
        String sql = "SELECT o.*, u.full_name, u.email FROM Orders o "
                + "LEFT JOIN User u ON o.user_id = u.id "
                + "ORDER BY o.order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapOrder(rs, false));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<OrderDetail> getOrderDetail(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.*, b.title FROM OrderDetail od "
                + "JOIN Book b ON od.book_id = b.id WHERE od.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));

                OrderDetail detail = new OrderDetail();
                detail.setId(rs.getInt("id"));
                detail.setOrderId(orderId);
                detail.setBook(book);
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("price"));
                list.add(detail);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int insert(Orders order) {
        String sql = "INSERT INTO Orders(user_id, total_price, status, shipping_address, shipping_phone, voucher_id, order_date) "
                + "VALUES(?,?,?,?,?,?,NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            if (order.getUser() != null && order.getUser().getId() > 0) {
                ps.setInt(1, order.getUser().getId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setDouble(2, order.getTotalPrice());
            ps.setString(3, order.getStatus() == null ? "Chờ xác nhận" : order.getStatus());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getShippingPhone());
            if (order.getVoucher() != null && order.getVoucher().getId() > 0) {
                ps.setInt(6, order.getVoucher().getId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    public int insertOrder(Orders order) {
        return insert(order);
    }

    public int insert(Connection conn, Orders order) throws Exception {
        String sql = "INSERT INTO Orders(user_id, total_price, status, shipping_address, shipping_phone, voucher_id, order_date) "
                + "VALUES(?,?,?,?,?,?,NOW())";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            if (order.getUser() != null && order.getUser().getId() > 0) {
                ps.setInt(1, order.getUser().getId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setDouble(2, order.getTotalPrice());
            ps.setString(3, order.getStatus() == null ? "Chờ xác nhận" : order.getStatus());
            ps.setString(4, order.getShippingAddress());
            ps.setString(5, order.getShippingPhone());
            if (order.getVoucher() != null && order.getVoucher().getId() > 0) {
                ps.setInt(6, order.getVoucher().getId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return -1;
    }

    public void deleteOrder(int orderId) {
        String deleteDetailSql = "DELETE FROM OrderDetail WHERE order_id = ?";
        String deleteOrderSql = "DELETE FROM Orders WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(deleteDetailSql)) {
                ps.setInt(1, orderId);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = conn.prepareStatement(deleteOrderSql)) {
                ps.setInt(1, orderId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int orderId) {
        deleteOrder(orderId);
    }

    public void updateStatus(int orderId, String status) {
        String sql = "UPDATE Orders SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Orders getById(int orderId) {
        String sql = "SELECT o.*, u.full_name, u.email FROM Orders o "
                + "LEFT JOIN User u ON o.user_id = u.id WHERE o.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapOrder(rs, true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public String getPaymentMethod(int orderId) {
        return null;
    }

    private Orders mapOrder(ResultSet rs, boolean includeDetails) throws Exception {
        Orders order = new Orders();
        order.setId(rs.getInt("id"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setShippingPhone(rs.getString("shipping_phone"));

        int userId = rs.getInt("user_id");
        if (!rs.wasNull()) {
            User user = new User();
            user.setId(userId);
            user.setFullName(rs.getString("full_name"));
            user.setEmail(rs.getString("email"));
            order.setUser(user);
            order.setRecipientName(user.getFullName());
            order.setRecipientEmail(user.getEmail());
        } else {
            order.setRecipientName("Khách vãng lai");
        }

        if (includeDetails) {
            order.setOrderDetails(getOrderDetail(order.getId()));
        }

        return order;
    }
}
