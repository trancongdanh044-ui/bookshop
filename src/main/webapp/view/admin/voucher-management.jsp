<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý voucher</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 mb-0">Quản lý voucher</h1>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/AdminController?action=addVoucher">Thêm voucher</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>Mã</th>
                                <th>Loại</th>
                                <th>Giảm</th>
                                <th>Đơn tối thiểu</th>
                                <th>Số lượng</th>
                                <th>Bắt đầu</th>
                                <th>Kết thúc</th>
                                <th>Trạng thái</th>
                                <th class="text-end">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="voucher" items="${vouchers}">
                                <tr>
                                    <td>${voucher.code}</td>
                                    <td>${voucher.type}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${voucher.type == 'percent'}">${voucher.discount}%</c:when>
                                            <c:otherwise><fmt:formatNumber value="${voucher.discount}" pattern="#,##0"/>đ</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatNumber value="${voucher.minOrderValue}" pattern="#,##0"/>đ</td>
                                    <td>${voucher.quantity}</td>
                                    <td><fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${voucher.quantity > 0 && voucher.endDate.time >= today.time}">
                                                <span class="badge text-bg-success">Đang hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge text-bg-secondary">Không khả dụng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end">
                                        <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/AdminController?action=editVoucher&voucherId=${voucher.id}">Sửa</a>
                                        <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/AdminController?action=deleteVoucher&voucherId=${voucher.id}" onclick="return confirm('Xóa voucher này?');">Xóa</a>
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
