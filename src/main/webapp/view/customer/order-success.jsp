<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card shadow-sm text-center">
                    <div class="card-body p-5">
                        <h1 class="h3 text-success mb-3">Đặt hàng thành công</h1>
                        <p class="mb-1">Mã đơn hàng: <strong>#${orderId}</strong></p>
                        <p class="mb-1">Người nhận: <strong>${recipientName}</strong></p>
                        <c:if test="${not empty recipientEmail}">
                            <p class="mb-1">Email nhận thông báo: <strong>${recipientEmail}</strong></p>
                        </c:if>
                        <p class="mb-3">Tổng thanh toán: <strong class="text-danger"><fmt:formatNumber value="${orderTotal}" pattern="#,##0"/>đ</strong></p>

                        <c:if test="${discountAmount > 0}">
                            <div class="alert alert-success">Đơn hàng đã áp dụng giảm giá <fmt:formatNumber value="${discountAmount}" pattern="#,##0"/>đ.</div>
                        </c:if>

                        <c:choose>
                            <c:when test="${paymentMethod == 'online'}">
                                <div class="alert alert-info">Đơn hàng đang chờ xác nhận thanh toán trực tuyến.</div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info">Bạn sẽ thanh toán khi nhận hàng.</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/OrderController?action=history">Xem lịch sử mua hàng</a>
                            <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/BookController">Tiếp tục mua sắm</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
