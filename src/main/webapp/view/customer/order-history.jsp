<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử mua hàng</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <h1 class="h3 mb-4">Lịch sử mua hàng</h1>

        <c:if test="${empty orders}">
            <div class="alert alert-info">
                Bạn chưa có đơn hàng nào. <a href="${pageContext.request.contextPath}/BookController">Mua sách ngay</a>
            </div>
        </c:if>

        <c:forEach var="order" items="${orders}">
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="d-flex flex-column flex-md-row justify-content-between mb-3">
                        <div>
                            <div class="fw-bold">Đơn #${order.id}</div>
                            <div class="text-muted small">
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                        </div>
                        <div class="text-md-end">
                            <div class="fw-semibold text-danger"><fmt:formatNumber value="${order.totalPrice}" pattern="#,##0"/>đ</div>
                            <span class="badge text-bg-primary">${order.status}</span>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-4"><strong>Khách hàng:</strong> ${order.recipientName}</div>
                        <div class="col-md-4"><strong>SĐT:</strong> ${order.shippingPhone}</div>
                        <div class="col-md-4"><strong>Thanh toán:</strong> ${order.paymentMethod}</div>
                    </div>
                    <div class="mb-3"><strong>Địa chỉ nhận:</strong> ${order.shippingAddress}</div>

                    <div class="table-responsive">
                        <table class="table table-sm">
                            <thead>
                                <tr>
                                    <th>Sách</th>
                                    <th>Số lượng</th>
                                    <th>Đơn giá</th>
                                    <th>Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${order.orderDetails}">
                                    <tr>
                                        <td>${detail.book.title}</td>
                                        <td>${detail.quantity}</td>
                                        <td><fmt:formatNumber value="${detail.price}" pattern="#,##0"/>đ</td>
                                        <td><fmt:formatNumber value="${detail.price * detail.quantity}" pattern="#,##0"/>đ</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
