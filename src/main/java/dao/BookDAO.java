package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Book;
import model.Category;
import util.DBConnection;

public class BookDAO {
    
    // THÊM METHOD 1: Lấy sách theo category (ĐƠN GIẢN, KHÔNG CẦN PHÂN TRANG)
    public List<Book> getByCategory(int categoryId) {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT b.*, c.name FROM Book b " +
                     "LEFT JOIN Category c ON b.category_id = c.id " +
                     "WHERE b.category_id = ? " +
                     "ORDER BY b.id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapBook(rs, true));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // THÊM METHOD 2: Lấy tất cả categories (cho dropdown)
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category ORDER BY name";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

// Thêm method này vào BookDAO.java
public List<Book> searchByKeywordAndCategory(String keyword, int categoryId) {
    List<Book> list = new ArrayList<>();
    String sql = "SELECT b.*, c.name FROM Book b "
            + "LEFT JOIN Category c ON b.category_id = c.id "
            + "WHERE (LOWER(b.title) LIKE ? OR LOWER(b.author) LIKE ? OR LOWER(c.name) LIKE ? OR CAST(b.price AS CHAR) LIKE ?) "
            + "AND b.category_id = ? "
            + "ORDER BY b.id DESC";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        String key = "%" + keyword.toLowerCase() + "%";
        ps.setString(1, key);
        ps.setString(2, key);
        ps.setString(3, key);
        ps.setString(4, key);
        ps.setInt(5, categoryId);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(mapBook(rs, true));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    public List<Book> getAll() {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT b.*, c.name FROM Book b LEFT JOIN Category c ON b.category_id = c.id ORDER BY b.id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapBook(rs, true));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Book getById(int id) {
        String sql = "SELECT b.*, c.name FROM Book b LEFT JOIN Category c ON b.category_id = c.id WHERE b.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapBook(rs, true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void insert(Book book) {
        String sql = "INSERT INTO Book(title, author, description, price, discount, quantity, image, category_id) VALUES(?,?,?,?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            bindBook(ps, book);
            if (ps.executeUpdate() == 0) {
                throw new IllegalStateException("Khong co dong nao duoc them vao bang Book.");
            }
        } catch (Exception e) {
            throw new RuntimeException("Khong the them sach vao co so du lieu.", e);
        }
    }

    public void update(Book book) {
        String sql = "UPDATE Book SET title=?, author=?, description=?, price=?, discount=?, quantity=?, image=?, category_id=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            bindBook(ps, book);
            ps.setInt(9, book.getId());
            if (ps.executeUpdate() == 0) {
                throw new IllegalStateException("Khong tim thay sach de cap nhat voi id=" + book.getId());
            }
        } catch (Exception e) {
            throw new RuntimeException("Khong the cap nhat sach trong co so du lieu.", e);
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM Book WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            if (ps.executeUpdate() == 0) {
                throw new IllegalStateException("Khong tim thay sach de xoa voi id=" + id);
            }
        } catch (Exception e) {
            throw new RuntimeException("Khong the xoa sach trong co so du lieu.", e);
        }
    }

    public List<Book> search(String keyword) {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT b.*, c.name FROM Book b "
                + "LEFT JOIN Category c ON b.category_id = c.id "
                + "WHERE LOWER(b.title) LIKE ? OR LOWER(b.author) LIKE ? OR LOWER(c.name) LIKE ? OR CAST(b.price AS CHAR) LIKE ? "
                + "ORDER BY b.id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String key = "%" + keyword.toLowerCase() + "%";
            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);
            ps.setString(4, key);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapBook(rs, true));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean reduceQuantity(Connection conn, int bookId, int quantity) throws Exception {
        String sql = "UPDATE Book SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, bookId);
            ps.setInt(3, quantity);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean reduceQuantity(int bookId, int quantity) {
        try (Connection conn = DBConnection.getConnection()) {
            return reduceQuantity(conn, bookId, quantity);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkQuantity(int bookId, int quantity) {
        String sql = "SELECT quantity FROM Book WHERE id = ? AND quantity >= ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookId);
            ps.setInt(2, quantity);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private void bindBook(PreparedStatement ps, Book book) throws Exception {
        ps.setString(1, book.getTitle());
        ps.setString(2, book.getAuthor());
        ps.setString(3, book.getDescription());
        ps.setDouble(4, book.getPrice());
        ps.setDouble(5, book.getDiscount());
        ps.setInt(6, book.getQuantity());
        ps.setString(7, book.getImage());
        if (book.getCategory() != null) {
            ps.setInt(8, book.getCategory().getId());
        } else {
            ps.setNull(8, java.sql.Types.INTEGER);
        }
    }

    private Book mapBook(ResultSet rs, boolean includeCategory) throws Exception {
        Category category = null;
        if (includeCategory) {
            category = new Category(rs.getInt("category_id"), rs.getString("name"));
        }

        return new Book(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("description"),
                rs.getDouble("price"),
                rs.getDouble("discount"),
                rs.getInt("quantity"),
                rs.getString("image"),
                category
        );
    }
}
