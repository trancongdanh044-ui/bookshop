# 🚀 Hướng Dẫn Build & Test BookShop

## 1️⃣ Build Project

### Lệnh Maven
```bash
cd BookShop
mvn clean compile
mvn package
```

### In NetBeans
1. Chuột phải trên project
2. Chọn "Clean and Build"
3. Hoặc: Shift + F11

---

## 2️⃣ Deploy lên Tomcat

### Cách 1: Tự động trong NetBeans
1. Chuột phải project → "Deploy"
2. Hoặc: Run → F6

### Cách 2: Thủ công
1. Copy file WAR từ `target/BookShop-1.0-SNAPSHOT.war`
2. Paste vào folder `%TOMCAT_HOME%\webapps\`
3. Khởi động Tomcat

---

## 3️⃣ Cài Đặt Database

### Tạo Database MySQL
```sql
CREATE DATABASE bookshop_v2;
USE bookshop_v2;

-- Tạo bảng User
CREATE TABLE User (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    email VARCHAR(100),
    fullName VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    role VARCHAR(20),
    totalSpent DOUBLE DEFAULT 0,
    membershipTier VARCHAR(20)
);

-- Tạo bảng Category
CREATE TABLE Category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE
);

-- Tạo bảng Book
CREATE TABLE Book (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    author VARCHAR(100),
    description TEXT,
    price DOUBLE,
    quantity INT,
    image VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(id)
);

-- Tạo bảng Voucher
CREATE TABLE Voucher (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE,
    discount DOUBLE,
    type VARCHAR(20),
    start_date DATE,
    end_date DATE,
    quantity INT,
    min_order_value DOUBLE
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price DOUBLE,
    status VARCHAR(50),
    shipping_address VARCHAR(255),
    shipping_phone VARCHAR(20),
    payment_method VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES User(id)
);

-- Tạo bảng OrderDetail
CREATE TABLE OrderDetail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (book_id) REFERENCES Book(id)
);

-- Tạo bảng Cart
CREATE TABLE Cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    created_date TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(id)
);

-- Tạo bảng CartItem
CREATE TABLE CartItem (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cart_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (cart_id) REFERENCES Cart(id),
    FOREIGN KEY (book_id) REFERENCES Book(id)
);

-- Thêm dữ liệu mẫu
-- 1. Thêm Category
INSERT INTO Category (name) VALUES 
('Văn Học'),
('Khoa Học'),
('Công Nghệ'),
('Tâm Lý');

-- 2. Thêm sách mẫu
INSERT INTO Book (title, author, description, price, quantity, category_id) VALUES 
('Lama Tây Tạng', 'A. David Nolan', 'Câu chuyện về tâm linh', 150000, 10, 4),
('Thức Tỉnh Dentro De Ti', 'Mark', 'Khám phá bản thân', 200000, 5, 4),
('Python Programming', 'Guido', 'Lập trình Python cơ bản', 250000, 15, 3),
('Atomic Habits', 'James Clear', 'Phát triển thói quen tốt', 180000, 8, 4);

-- 3. Thêm admin user
INSERT INTO User (username, password, email, fullName, phone, address, role) VALUES 
('admin', 'admin123', 'admin@bookshop.com', 'Admin', '0123456789', 'TPHCM', 'admin');

-- 4. Thêm khách hàng mẫu
INSERT INTO User (username, password, email, fullName, phone, address, role) VALUES 
('customer1', 'pass123', 'customer@email.com', 'Nguyễn Văn A', '0987654321', 'Hà Nội', 'customer');
```

### Cập nhật DBConnection.java
```java
// Sửa lại trong src/main/java/util/DBConnection.java
private static final String URL = "jdbc:mysql://localhost:3306/bookshop_v2";
private static final String USER = "root";  // username MySQL
private static final String PASSWORD = "your_password";  // password MySQL
```

---

## 4️⃣ Test Chức Năng

### Test 1: Xem Danh Sách Sách (Guest)
1. Mở trình duyệt: `http://localhost:8080/BookShop/`
2. Kiểm tra: Hiển thị danh sách sách, phân trang

### Test 2: Thêm Giỏ Hàng
1. Click "Thêm vào giỏ" trên sách nào đó
2. Kiểm tra: Số lượng giỏ hàng tăng (#)

### Test 3: Xem Giỏ Hàng
1. Click vào giỏ hàng (icon)
2. Kiểm tra: Xem tất cả sách đã thêm
3. Cập nhật số lượng
4. Xóa sách

### Test 4: Thanh Toán (Guest)
1. Click "Thanh Toán" từ giỏ hàng
2. Nhập Email, Tên (nếu không đăng nhập)
3. Nhập địa chỉ, số điện thoại
4. Chọn phương thức: COD hoặc Online
5. Click "Xác Nhận Đặt Hàng"
6. Kiểm tra: Hiển thị trang thành công

### Test 5: Admin - Thêm Sách
1. Đăng nhập: username=`admin`, password=`admin123`
2. Vào "Admin" → "Quản Lý Sách"
3. Click "Thêm Sách Mới"
4. Nhập thông tin sách
5. Click "Thêm Mới"
6. Kiểm tra: Sách mới hiển thị trong danh sách

### Test 6: Admin - Sửa Sách
1. Từ danh sách sách, click "Sửa" trên sách nào đó
2. Thay đổi thông tin (giá, số lượng)
3. Click "Cập Nhật"
4. Kiểm tra: Thông tin được cập nhật

### Test 7: Admin - Tạo Voucher
1. Vào "Admin" → "Quản Lý Voucher"
2. Click "Thêm Voucher Mới"
3. Nhập:
   - Mã: SAVE20
   - Giá trị: 20
   - Loại: Phần Trăm (%)
   - Số lượng: 100
   - Giá tối thiểu: 100000
4. Click "Tạo Voucher"
5. Kiểm tra: Voucher mới có trong danh sách

### Test 8: Admin - Quản Lý Đơn Hàng
1. Vào "Admin" → "Quản Lý Đơn Hàng"
2. Xem danh sách đơn hàng từ Test 4
3. Click cập nhật trạng thái: Processing → Shipped
4. Kiểm tra: Trạng thái được thay đổi

### Test 9: Áp Dụng Voucher
1. Thêm sách vào giỏ (giá > 100,000đ)
2. Click "Thanh Toán"
3. Nhập mã voucher: SAVE20
4. Kiểm tra: Tổng tiền giảm 20%

### Test 10: Xử Lý Tồn Kho
1. Tạo sách với số lượng = 1
2. Mở 2 trình duyệt khác nhau
3. Trình duyệt 1: Thêm sách, thanh toán
4. Trình duyệt 2: Thêm sách, thử thanh toán
5. Kiểm tra: Trình duyệt 2 nhận lỗi "Hết hàng"

---

## 5️⃣ Khắc Phục Lỗi Thường Gặp

### Error: "Cannot find driver"
**Giải pháp**: Kiểm tra MySQL connector jar trong pom.xml
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>9.6.0</version>
</dependency>
```

### Error: "Access denied for user 'root'@'localhost'"
**Giải pháp**: Cập nhật username/password trong DBConnection.java

### Error: "Table not found"
**Giải pháp**: Chạy SQL script để tạo bảng

### Error: "404 Not Found"
**Giải pháp**: Kiểm tra URL routing đúng (ví dụ: BookController không phải book)

### JSP không render
**Giải pháp**: Kiểm tra path trong `forward()` hoặc `include()`

---

## 6️⃣ Configuration Tùy Chỉnh

### Thay Đổi Số Sản Phẩm/Trang
**File**: `BookController.java`
```java
private static final int ITEMS_PER_PAGE = 30; // Thay 30 thành số khác
```

### Thay Đổi Thông tin Voucher Mặc Định
**File**: `AdminController.java`
```java
// Thay đổi ngày hết hạn mặc định (30 ngày)
voucher.setEndDate(new Date(System.currentTimeMillis() + 30 * 24 * 60 * 60 * 1000));
```

---

## 7️⃣ Production Checklist

- [ ] Thay đổi password database
- [ ] Cập nhật URL database cho production
- [ ] Kiểm tra HTTPS/SSL
- [ ] Cấu hình tiền tố URL (`/BookShop` → `/`)
- [ ] Thêm logging
- [ ] Bảo mật: Mã hóa password
- [ ] Bảo mật: Validate input
- [ ] Bảo mật: CSRF tokens
- [ ] Backup database định kỳ
- [ ] Monitor hiệu suất

---

## 📞 Support & Troubleshooting

**MySQL Localhost**
```
Host: localhost
Port: 3306
User: root
DB: bookshop_v2
```

**Tomcat**
```
URL: http://localhost:8080/BookShop/
Port: 8080 (có thể thay đổi trong conf/server.xml)
```

**Logs**
```
Tomcat: catalina.out
Database: MySQL error log
```

---

✅ **Đã sẵn sàng để chạy!**
