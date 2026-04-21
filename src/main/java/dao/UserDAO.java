package dao;

import java.sql.*;
import java.util.*;
import model.User;
import util.DBConnection;

public class UserDAO {

    // login
    public User login(String username, String password) {
        String sql = "SELECT * FROM User WHERE username=? AND password=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // lấy tất cả user
    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM User";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement()) {

            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // thêm user
    public void insert(User user) {
        String sql = "INSERT INTO User(username, password, email, full_name, phone, address, role) VALUES(?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getRole() != null ? user.getRole() : "customer");

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private User mapUser(ResultSet rs) throws Exception {
        return new User(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("email"),
            rs.getString("full_name"),
            rs.getString("phone"),
            rs.getString("address"),
            rs.getString("role"),
            rs.getDouble("total_spent"),
            rs.getString("membership_tier")
        );
    }
}