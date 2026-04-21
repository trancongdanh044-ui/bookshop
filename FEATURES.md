# BookShop - Hệ Thống Bán Sách Trực Tuyến

## Các Tính Năng Đã Cài Đặt

### 1. **Trang Chủ & Duyệt Sách (Guest Access)**
- Khách hàng có thể vào trang chủ mà **không cần đăng nhập**
- Hiển thị danh sách sách với **phân trang 30 sản phẩm/trang**
- Hiển thị thông tin: tên sách, tác giả, giá, số lượng tồn kho
- Nút "Thêm vào giỏ hàng" cho các sách còn hàng

**Controller:** `BookController.java`
**View:** `/view/customer/books-list.jsp`

---

### 2. **Giỏ Hàng (Shopping Cart)**
- **Thêm sách vào giỏ**: Kiểm tra số lượng tồn kho
- **Cập nhật số lượng**: Tăng/giảm số lượng từng sách
- **Xóa sách**: Xóa sách khỏi giỏ hàng
- **Xóa toàn bộ giỏ**: Làm trống giỏ hàng
- **Tính tổng tiền**: Tự động cập nhật tổng giá tiền
- Kiểm tra **không vượt quá số lượng tồn kho**

**Controller:** `CartController.java`
**View:** `/view/customer/cart.jsp`

---

### 3. **Thanh Toán & Đặt Hàng (Checkout)**
- Khách hàng **không cần đăng nhập** để thanh toán (Guest Checkout)
- Nếu chưa có tài khoản: nhập Email + Tên khách hàng
- Nếu đã đăng nhập: sử dụng thông tin từ hồ sơ

**Thông tin giao hàng:**
- Địa chỉ giao hàng
- Số điện thoại

**Phương Thức Thanh Toán:**
- ✓ **Thanh toán khi nhận hàng (COD)**: Khách hàng trả tiền khi nhận hàng
- ✓ **Thanh toán trực tuyến**: Thanh toán qua Visa, Mastercard, VNPay, Momo, ...

**Mã Voucher:** Tích hợp mã giảm giá

**Controller:** `OrderController.java`
**View:** `/view/customer/checkout.jsp`, `/view/customer/order-success.jsp`

---

### 4. **Quản Lý Sách (Admin)**
- Admin có thể **đăng nhập** vào hệ thống
- **Thêm sách mới**: Nhập tên, tác giả, giá, số lượng, danh mục, hình ảnh
- **Sửa thông tin sách**: Cập nhật các thông tin sách
- **Xóa sách**: Loại bỏ sách khỏi hệ thống
- **Danh sách sách**: Xem toàn bộ sách trong hệ thống

**Controller:** `AdminController.java`
**View:** `/view/admin/book-form.jsp`, `/view/admin/manage-books.jsp`

---

### 5. **Quản Lý Voucher (Admin)**
- Admin có thể **tạo voucher mới**
- **Các loại voucher:**
  - Giảm giá theo **phần trăm (%)**: ví dụ SAVE20 giảm 20%
  - Giảm giá theo **số tiền cố định**: ví dụ giảm 50,000đ
- **Điều kiện voucher:**
  - Giá trị đơn hàng tối thiểu
  - Số lượng voucher có sẵn
  - Ngày bắt đầu/kết thúc

**Controller:** `AdminController.java` (action: `addVoucher`)
**View:** `/view/admin/voucher-form.jsp`,`/view/admin/manage-vouchers.jsp`
**DAO:** `VoucherDAO.java`

---

### 6. **Quản Lý Đơn Hàng (Admin)**
- Admin xem **danh sách tất cả đơn hàng**
- Xem chi tiết đơn hàng: sách, số lượng, giá
- **Cập nhật trạng thái:**
  - Pending (Chưa xử lý)
  - Processing (Đang xử lý)
  - Shipped (Đã gửi)
  - Delivered (Đã giao)
  - Canceled (Hủy)

**Controller:** `AdminController.java` (action: `manageOrders`)
**View:** `/view/admin/manage-orders.jsp`

---

### 7. **Xử Lý Tồn Kho (Concurrent Purchases)**
Khi còn **1 quyển sách** và **nhiều người mua cùng lúc**:

**Cơ chế:**
1. Kiểm tra số lượng tồn kho **trước khi tạo đơn hàng**
2. Nếu không đủ: **từ chối đơn hàng** và yêu cầu thử lại
3. Nếu đủ: **cập nhật số lượng tồn kho** và tạo đơn hàng
4. Sử dụng **transaction** để đảm bảo tính nhất quán dữ liệu

**DAO Methods:**
- `BookDAO.getById()`: Lấy thông tin sách và số lượng
- `BookDAO.update()`: Cập nhật số lượng sách
- `OrdersDAO.deleteOrder()`: Xóa đơn hàng nếu thất bại

---

## Cấu Trúc Dữ Liệu

### Bảng Orders (Đơn Hàng)
```sql
CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    created_date TIMESTAMP,
    total_price DOUBLE,
    status VARCHAR(50),
    shipping_address VARCHAR(255),
    shipping_phone VARCHAR(20),
    payment_method VARCHAR(50), -- 'cod' hoặc 'online'
    FOREIGN KEY (user_id) REFERENCES User(id)
);
```

### Bảng OrderDetail (Chi Tiết Đơn Hàng)
```sql
CREATE TABLE OrderDetail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    price DOUBLE,
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (book_id) REFERENCES Book(id)
);
```

### Bảng Voucher
```sql
CREATE TABLE Voucher (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE,
    discount DOUBLE,
    type VARCHAR(20), -- 'percent' hoặc 'fixed'
    start_date DATE,
    end_date DATE,
    quantity INT,
    min_order_value DOUBLE
);
```

---

## Controllers (Điểm Vào)

### 1. **CartController**
Route: `/CartController`
- `?action=add&id=<bookId>&quantity=<qty>` - Thêm vào giỏ
- `?action=update&id=<bookId>&quantity=<qty>` - Cập nhật số lượng
- `?action=remove&id=<bookId>` - Xóa khỏi giỏ
- `?action=clear` - Xóa toàn bộ giỏ

### 2. **OrderController**
Route: `/OrderController`
- `?action=checkout` - Xem trang thanh toán
- `POST http://localhost:8080/OrderController` (action=process) - Xử lý đơn hàng
- `?action=history` - Xem lịch sử đơn hàng

### 3. **AdminController**
Route: `/AdminController`
- `?action=manageBooks` - Quản lý sách
- `?action=addBook` - Thêm sách mới
- `?action=editBook&bookId=<id>` - Sửa sách
- `?action=manageOrders` - Quản lý đơn hàng
- `?action=manageVouchers` - Quản lý voucher
- `?action=addVoucher` - Thêm voucher

### 4. **BookController**
Route: `/BookController`
- `?page=<number>` - Xem danh sách sách (phân trang)
- `?action=detail&bookId=<id>` - Xem chi tiết sách

### 5. **AuthController**
Route: `/AuthController`
- `POST` (action=login) - Đăng nhập
- `POST` (action=register) - Đăng ký
- `?action=logout` - Đăng xuất

---

## Tệp JSP Chính

```
view/
├── admin/
│   ├── book-form.jsp (Thêm/sửa sách)
│   ├── manage-books.jsp (Danh sách sách)
│   ├── manage-orders.jsp (Danh sách đơn)
│   ├── manage-vouchers.jsp (Danh sách voucher)
│   ├── voucher-form.jsp (Thêm voucher)
│   └── dashboard.jsp (Bảng điều khiển)
├── customer/
│   ├── books-list.jsp (Danh sách sách)
│   ├── cart.jsp (Giỏ hàng)
│   ├── checkout.jsp (Trang thanh toán)
│   ├── order-success.jsp (Đặt hàng thành công)
│   └── order-history.jsp (Lịch sử đơn hàng)
└── common/
    ├── header.jsp (Menu)
    └── footer.jsp (Chân trang)
```

---

## Công Nghệ Sử Dụng

- **Backend**: Java Servlet, JDBC
- **Frontend**: Bootstrap 5, JSP, JSTL, EL
- **Database**: MySQL
- **Server**: Apache Tomcat

---

## Một Số Chú Ý Quan Trọng

1. **Guest Checkout**: Khách hàng có thể mua hàng mà không cần đăng nhập hoặc đăng ký
2. **Phân Trang**: Mỗi trang hiển thị tối đa 30 sản phẩm
3. **Xử Lý Tồn Kho**: Ngăn chặn overbooking khi nhiều người mua cùng lúc
4. **Voucher**: Hỗ trợ cả giảm giá theo phần trăm và số tiền cố định
5. **Phương Thức Thanh Toán**: COD (tiền mặt) và Online (các cổng thanh toán)
6. **Lịch Sử Đơn Hàng**: Khách hàng đăng nhập có thể xem lịch sử mua hàng

---

## Cài Đặt & Chạy

1. **Tạo cơ sở dữ liệu**: Chạy script SQL để tạo các bảng
2. **Cập nhật kết nối DB**: Sửa `DBConnection.java` với thông tin MySQL của bạn
3. **Build project**: `mvn clean install`
4. **Deploy**: Copy WAR file vào thư mục `webapps` của Tomcat
5. **Chạy**: Khởi động Tomcat và truy cập `http://localhost:8080/BookShop`

---

Tất cả các yêu cầu đã được hoàn thành! 🎉
