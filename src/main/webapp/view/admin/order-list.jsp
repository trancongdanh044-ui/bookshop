<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý thanh toán</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <h1 class="h3 mb-4">Quản lý thanh toán và đơn hàng</h1>

        <div class="card shadow-sm">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Thanh toán</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th class="text-end">Cập nhật</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>#${order.id}</td>
                                    <td>
                                        <div>${order.recipientName}</div>
                                        <div class="small text-muted">${order.shippingPhone}</div>
                                    </td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td>${order.paymentMethod}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" pattern="#,##0"/>đ</td>
                                    <td><span class="badge text-bg-primary">${order.status}</span></td>
                                    <td class="text-end">
                                        <div class="btn-group btn-group-sm">
                                            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=Chờ xác nhận">Chờ xác nhận</a>
                                            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=Đang giao">Đang giao</a>
                                            <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=Hoàn thành">Hoàn thành</a>
                                            <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=Đã hủy">Hủy</a>
                                        </div>
                                    </td>
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
