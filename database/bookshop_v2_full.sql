DROP DATABASE IF EXISTS bookshop_v2;
CREATE DATABASE bookshop_v2 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bookshop_v2;

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    full_name VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    role VARCHAR(20) DEFAULT 'user',
    total_spent DOUBLE DEFAULT 0,
    membership_tier VARCHAR(50) DEFAULT 'Đồng'
);

CREATE TABLE Category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Book (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    description TEXT,
    price DOUBLE NOT NULL,
    discount DOUBLE DEFAULT 0,
    quantity INT NOT NULL,
    image VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(id) ON DELETE SET NULL
);

CREATE TABLE Cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

CREATE TABLE CartItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT,
    book_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES Cart(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Book(id) ON DELETE CASCADE
);

CREATE TABLE Voucher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    discount DOUBLE NOT NULL,
    type VARCHAR(20) NOT NULL,
    start_date DATE,
    end_date DATE,
    quantity INT DEFAULT 0,
    min_order_value DOUBLE DEFAULT 0
);

CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_price DOUBLE,
    status VARCHAR(50) DEFAULT 'Chờ xác nhận',
    shipping_address VARCHAR(255),
    shipping_phone VARCHAR(15),
    voucher_id INT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (voucher_id) REFERENCES Voucher(id)
);

CREATE TABLE OrderDetail (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Book(id)
);

CREATE TABLE Review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    book_id INT,
    rating INT,
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_review_rating CHECK (rating >= 1 AND rating <= 5),
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Book(id) ON DELETE CASCADE
);

INSERT INTO User (username, password, email, full_name, phone, address, role, total_spent, membership_tier) VALUES
('admin', '123456', 'admin@bookshop.com', 'Quản Trị Viên', '0901234567', 'Hà Nội', 'admin', 0, 'Admin'),
('nguyenvana', '123456', 'nva@gmail.com', 'Nguyễn Văn A', '0911111111', 'Quận 1, TP.HCM', 'user', 500000, 'Bạc'),
('tranthib', '123456', 'ttb@gmail.com', 'Trần Thị B', '0922222222', 'Cầu Giấy, Hà Nội', 'user', 1500000, 'Vàng'),
('lecongc', '123456', 'lcc@gmail.com', 'Lê Công C', '0933333333', 'Hải Châu, Đà Nẵng', 'user', 0, 'Đồng'),
('phamvand', '123456', 'pvd@gmail.com', 'Phạm Văn D', '0944444444', 'Ninh Kiều, Cần Thơ', 'user', 200000, 'Đồng'),
('hoangthie', '123456', 'hte@gmail.com', 'Hoàng Thị E', '0955555555', 'Vinh, Nghệ An', 'user', 3000000, 'Kim Cương'),
('vuvang', '123456', 'vvg@gmail.com', 'Vũ Văn G', '0966666666', 'Huế', 'user', 50000, 'Đồng'),
('ngothih', '123456', 'nth@gmail.com', 'Ngô Thị H', '0977777777', 'Nha Trang, Khánh Hòa', 'user', 600000, 'Bạc'),
('dinhvani', '123456', 'dvi@gmail.com', 'Đinh Văn I', '0988888888', 'Thủ Đức, TP.HCM', 'user', 1200000, 'Vàng'),
('buiduck', '123456', 'bdk@gmail.com', 'Bùi Đức K', '0999999999', 'Hạ Long, Quảng Ninh', 'user', 0, 'Đồng');

INSERT INTO Category (name) VALUES
('Văn học - Tiểu thuyết'),
('Kinh tế - Khởi nghiệp'),
('Tâm lý - Kỹ năng sống'),
('Sách Thiếu nhi'),
('Khoa học - Viễn tưởng'),
('Lịch sử - Địa lý'),
('Ngoại ngữ'),
('Công nghệ thông tin'),
('Sách Giáo Khoa'),
('Truyện tranh (Manga/Comic)');

INSERT INTO Book (title, author, description, price, discount, quantity, image, category_id) VALUES
('Nhà Giả Kim', 'Paulo Coelho', 'Cuốn sách bán chạy nhất mọi thời đại.', 75000, 5000, 50, 'nhagiakim.jpg', 1),
('Đắc Nhân Tâm', 'Dale Carnegie', 'Nghệ thuật thu phục lòng người.', 80000, 0, 100, 'dacnhantam.jpg', 3),
('Clean Code', 'Robert C. Martin', 'Sách gối đầu giường cho dân IT.', 250000, 20000, 30, 'cleancode.jpg', 8),
('Cha Giàu Cha Nghèo', 'Robert Kiyosaki', 'Bí quyết quản lý tài chính cá nhân.', 110000, 10000, 60, 'chagiau.jpg', 2),
('Dế Mèn Phiêu Lưu Ký', 'Tô Hoài', 'Truyện thiếu nhi kinh điển Việt Nam.', 45000, 0, 80, 'demen.jpg', 4),
('Sự Lược Sử Loài Người', 'Yuval Noah Harari', 'Khám phá lịch sử phát triển loài người.', 180000, 15000, 40, 'luocsu.jpg', 6),
('Sherlock Holmes', 'Arthur Conan Doyle', 'Tuyển tập truyện trinh thám.', 150000, 10000, 25, 'sherlock.jpg', 1),
('Hack Não 1500 Từ Tiếng Anh', 'Step Up', 'Phương pháp học từ vựng siêu tốc.', 350000, 50000, 15, 'hacknao.jpg', 7),
('Doraemon Tập 1', 'Fujiko F. Fujio', 'Chú mèo máy đến từ tương lai.', 20000, 0, 200, 'doraemon1.jpg', 10),
('Vũ Trụ', 'Carl Sagan', 'Khám phá dải ngân hà và vũ trụ.', 160000, 10000, 35, 'vutru.jpg', 5);

INSERT INTO Cart (user_id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

INSERT INTO CartItem (cart_id, book_id, quantity) VALUES
(2, 1, 2),
(2, 3, 1),
(3, 2, 1),
(4, 4, 3),
(5, 5, 1),
(6, 8, 1),
(7, 10, 2),
(8, 6, 1),
(9, 7, 1),
(10, 9, 5);

INSERT INTO Voucher (code, discount, type, start_date, end_date, quantity, min_order_value) VALUES
('GIAM10K', 10000, 'fixed', '2026-01-01', '2026-12-31', 100, 50000),
('GIAM20K', 20000, 'fixed', '2026-01-01', '2026-12-31', 50, 100000),
('GIAM50K', 50000, 'fixed', '2026-01-01', '2026-12-31', 20, 300000),
('SALE10', 10, 'percent', '2026-01-01', '2026-12-31', 100, 150000),
('SALE20', 20, 'percent', '2026-01-01', '2026-12-31', 50, 250000),
('FREESHIP', 15000, 'fixed', '2026-01-01', '2026-12-31', 200, 0),
('MEMBERVIP', 15, 'percent', '2026-01-01', '2026-12-31', 30, 200000),
('TET2026', 30000, 'fixed', '2026-01-01', '2026-02-28', 100, 200000),
('BACKTOSCHOOL', 10, 'percent', '2026-08-01', '2026-09-30', 150, 100000),
('BLACKFRIDAY', 50, 'percent', '2026-11-20', '2026-11-30', 10, 500000);

INSERT INTO Orders (user_id, order_date, total_price, status, shipping_address, shipping_phone, voucher_id) VALUES
(2, '2026-01-15 09:30:00', 140000, 'Hoàn thành', 'Quận 1, TP.HCM', '0911111111', 1),
(3, '2026-01-18 14:20:00', 80000, 'Đang giao', 'Cầu Giấy, Hà Nội', '0922222222', NULL),
(5, '2026-01-20 10:15:00', 30000, 'Chờ xác nhận', 'Ninh Kiều, Cần Thơ', '0944444444', 6),
(6, '2026-01-22 16:45:00', 300000, 'Hoàn thành', 'Vinh, Nghệ An', '0955555555', 4),
(8, '2026-01-25 11:10:00', 165000, 'Đã hủy', 'Nha Trang, Khánh Hòa', '0977777777', NULL),
(9, '2026-01-28 08:50:00', 140000, 'Đang giao', 'Thủ Đức, TP.HCM', '0988888888', 2),
(2, '2026-02-02 13:05:00', 308000, 'Hoàn thành', 'Quận 1, TP.HCM', '0911111111', 5),
(3, '2026-02-03 17:35:00', 100000, 'Chờ xác nhận', 'Cầu Giấy, Hà Nội', '0922222222', NULL),
(6, '2026-02-06 19:25:00', 230000, 'Hoàn thành', 'Vinh, Nghệ An', '0955555555', 7),
(7, '2026-02-10 07:40:00', 20000, 'Chờ xác nhận', 'Huế', '0966666666', NULL);

INSERT INTO OrderDetail (order_id, book_id, quantity, price) VALUES
(1, 1, 2, 70000),
(2, 2, 1, 80000),
(3, 5, 1, 45000),
(4, 8, 1, 300000),
(5, 6, 1, 165000),
(6, 7, 1, 140000),
(7, 3, 1, 230000),
(7, 4, 1, 100000),
(8, 4, 1, 100000),
(9, 3, 1, 230000),
(10, 9, 1, 20000);

INSERT INTO Review (user_id, book_id, rating, comment, review_date) VALUES
(2, 1, 5, 'Sách rất hay, đóng gói cẩn thận, giao hàng nhanh.', '2026-01-17 10:00:00'),
(3, 2, 4, 'Nội dung bổ ích, áp dụng được nhiều vào thực tế.', '2026-01-19 09:30:00'),
(6, 8, 5, 'Phương pháp học thú vị, sách in màu đẹp mắt.', '2026-01-24 14:20:00'),
(2, 3, 5, 'Kiến thức lập trình chuẩn xác, nên đọc.', '2026-02-05 08:45:00'),
(6, 3, 4, 'Sách hơi khó với người mới nhưng rất đáng tiền.', '2026-02-07 15:10:00'),
(8, 6, 3, 'Sách hay nhưng giao hàng hơi chậm.', '2026-01-26 13:50:00'),
(9, 7, 5, 'Truyện lôi cuốn từ đầu đến cuối.', '2026-01-29 16:15:00'),
(2, 4, 4, 'Kiến thức tài chính vỡ lòng rất tốt.', '2026-02-04 11:25:00'),
(7, 9, 5, 'Tuổi thơ ùa về, chất lượng giấy tốt.', '2026-02-11 09:00:00'),
(5, 5, 5, 'Truyện ngắn gọn, ý nghĩa sâu sắc cho thiếu nhi.', '2026-01-21 18:30:00');
