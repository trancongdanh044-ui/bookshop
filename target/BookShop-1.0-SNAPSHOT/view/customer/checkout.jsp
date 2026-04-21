<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <h1 class="h3 mb-4">Thanh toán đơn hàng</h1>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="row g-4">
            <div class="col-lg-7">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="h5 mb-3">Sản phẩm đã chọn</h2>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Sách</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="totalPrice" value="0"/>
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <c:set var="itemTotal" value="${item.book.finalPrice * item.quantity}"/>
                                    <c:set var="totalPrice" value="${totalPrice + itemTotal}"/>
                                    <tr>
                                        <td>${item.book.title}</td>
                                        <td><fmt:formatNumber value="${item.book.finalPrice}" pattern="#,##0"/>đ</td>
                                        <td>${item.quantity}</td>
                                        <td><fmt:formatNumber value="${itemTotal}" pattern="#,##0"/>đ</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="text-end fw-bold fs-5">
                            Tổng đơn: <span class="text-danger"><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/>đ</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/OrderController" method="post">
                            <h2 class="h5 mb-3">Thông tin nhận hàng</h2>
                            <div class="mb-3">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" class="form-control" name="fullName" value="${sessionScope.user.fullName}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" name="shippingPhone" value="${sessionScope.user.phone}" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ nhận hàng</label>
                                <textarea class="form-control" name="shippingAddress" rows="3" required>${sessionScope.user.address}</textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email nhận voucher/xác nhận đơn</label>
                                <input type="email" class="form-control" name="email" value="${sessionScope.user.email}">
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mã voucher</label>
                                <input type="text" class="form-control" name="voucherCode" placeholder="Nhập mã nếu có">
                            </div>

<!--                            <h2 class="h5 mb-3 mt-4">Phương thức thanh toán</h2>-->
                            <div class="form-check mb-2">
                                <input class="form-check-input" type="radio" name="paymentMethod" value="cod" id="cod" checked readOnly>
                                <label class="form-check-label" for="cod">Thanh toán khi nhận hàng</label>
                            </div>
<!--                            <div class="form-check mb-4">
                                <input class="form-check-input" type="radio" name="paymentMethod" value="online" id="online">
                                <label class="form-check-label" for="online">Thanh toán trực tuyến</label>
                            </div>-->

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Xác nhận đặt hàng</button>
                                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/CartController">Quay lại giỏ hàng</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
