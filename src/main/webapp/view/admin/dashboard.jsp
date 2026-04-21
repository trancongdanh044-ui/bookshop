<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 mb-0">Quản trị hệ thống</h1>
            <div class="d-flex gap-2">
                <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/AdminController?action=manageBooks">Quản lý sách</a>
                <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/AdminController?action=manageVouchers">Voucher</a>
                <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/AdminController?action=manageOrders">Thanh toán và đơn hàng</a>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="text-muted small">Số loại sách</div>
                        <div class="display-6">${bookCount}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="text-muted small">Đơn hàng</div>
                        <div class="display-6">${orderCount}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="text-muted small">Voucher</div>
                        <div class="display-6">${voucherCount}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="text-muted small">Doanh thu</div>
                        <div class="h3 text-danger mb-0"><fmt:formatNumber value="${revenue}" pattern="#,##0"/>đ</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="h5 mb-3">Đơn hàng gần đây</h2>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Thanh toán</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${recentOrders}">
                                <tr>
                                    <td>#${order.id}</td>
                                    <td>${order.recipientName}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>${order.paymentMethod}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" pattern="#,##0"/>đ</td>
                                    <td>${order.status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
