package dao;
import util.DBConnection;
import model.Category;
import java.sql.*;
import java.util.*;

public class CategoryDAO {
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Category ca = new Category();
                ca.setId(rs.getInt("id"));
                ca.setName(rs.getString("name"));
                list.add(ca);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}