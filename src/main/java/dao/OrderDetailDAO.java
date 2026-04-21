package dao;
import util.DBConnection;
import model.OrderDetail;
import java.sql.*;

public class OrderDetailDAO {

    public void insert(OrderDetail od) {
        String sql = "INSERT INTO OrderDetail (order_id, book_id, quantity, price) VALUES (?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            bind(ps, od);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insert(Connection conn, OrderDetail od) throws Exception {
        String sql = "INSERT INTO OrderDetail (order_id, book_id, quantity, price) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            bind(ps, od);
            ps.executeUpdate();
        }
    }

    private void bind(PreparedStatement ps, OrderDetail od) throws Exception {
        ps.setInt(1, od.getOrderId());
        ps.setInt(2, od.getBook().getId());
        ps.setInt(3, od.getQuantity());
        ps.setDouble(4, od.getPrice());
    }
}
