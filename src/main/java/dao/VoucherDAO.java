package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Voucher;
import util.DBConnection;

public class VoucherDAO {

    public Voucher findByCode(String code) {
        String sql = "SELECT * FROM Voucher WHERE code = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapVoucher(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public Voucher getByCode(String code) {
        return findByCode(code);
    }

    public Voucher getById(int id) {
        String sql = "SELECT * FROM Voucher WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapVoucher(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Voucher> getAll() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM Voucher ORDER BY start_date DESC, id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapVoucher(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Voucher> getAllVouchers() {
        return getAll();
    }

    public void insert(Voucher voucher) {
        String sql = "INSERT INTO Voucher(code, discount, type, start_date, end_date, quantity, min_order_value) "
                + "VALUES(?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            bindVoucher(ps, voucher);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void update(Voucher voucher) {
        String sql = "UPDATE Voucher SET code=?, discount=?, type=?, start_date=?, end_date=?, quantity=?, min_order_value=? "
                + "WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            bindVoucher(ps, voucher);
            ps.setInt(8, voucher.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Voucher WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void reduceQuantity(int voucherId) {
        String sql = "UPDATE Voucher SET quantity = quantity - 1 WHERE id = ? AND quantity > 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, voucherId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean reduceQuantity(Connection conn, int voucherId) throws Exception {
        String sql = "UPDATE Voucher SET quantity = quantity - 1 WHERE id = ? AND quantity > 0";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean isActive(Voucher voucher) {
        if (voucher == null) {
            return false;
        }

        Date now = new Date();
        return voucher.getQuantity() > 0
                && voucher.getStartDate() != null
                && voucher.getEndDate() != null
                && !now.before(voucher.getStartDate())
                && !now.after(voucher.getEndDate());
    }

    private Voucher mapVoucher(ResultSet rs) throws Exception {
        return new Voucher(
                rs.getInt("id"),
                rs.getString("code"),
                rs.getDouble("discount"),
                rs.getString("type"),
                rs.getDate("start_date"),
                rs.getDate("end_date"),
                rs.getInt("quantity"),
                rs.getDouble("min_order_value")
        );
    }

    private void bindVoucher(PreparedStatement ps, Voucher voucher) throws Exception {
        ps.setString(1, voucher.getCode());
        ps.setDouble(2, voucher.getDiscount());
        ps.setString(3, voucher.getType());
        ps.setDate(4, new java.sql.Date(voucher.getStartDate().getTime()));
        ps.setDate(5, new java.sql.Date(voucher.getEndDate().getTime()));
        ps.setInt(6, voucher.getQuantity());
        ps.setDouble(7, voucher.getMinOrderValue());
    }
}
