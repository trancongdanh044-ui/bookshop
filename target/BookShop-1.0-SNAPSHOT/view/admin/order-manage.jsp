<%@ include file="../common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng - BookShop Admin</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .table-container {
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        .status-confirmed {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status-shipping {
            background: #cfe2ff;
            color: #084298;
        }
        .status-delivered {
            background: #d1e7dd;
            color: #0f5132;
        }
        .status-cancelled {
            background: #f8d7da;
            color: #842029;
        }
    </style>
</head>
<body class="bg-light">
    <div class="admin-container">
        <h1><i class="fas fa-boxes mr-2"></i>Quản Lý Đơn Hàng</h1>
        <hr>

        <div class="table-container">
            <c:if test="${empty orders}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle mr-2"></i>Không có đơn hàng nào.
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="table-responsive">
                    <table class="table table-hover table-striped table-sm">
                        <thead class="table-light">
                            <tr>
                                <th>Mã Đơn</th>
                                <th>Khách Hàng</th>
                                <th>Email</th>
                                <th>Ngày Đặt</th>
                                <th>Tổng Tiền</th>
                                <th>Địa Chỉ Giao</th>
                                <th>Trạng Thái</th>
                                <th>Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td><strong>#${order.id}</strong></td>
                                    <td>${order.user.fullName}</td>
                                    <td>${order.user.email}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td><strong><fmt:formatNumber value="${order.totalPrice}" pattern="#,##0.00"/>đ</strong></td>
                                    <td>${order.shippingAddress}</td>
                                    <td>
                                        <span class="status-badge status-${order.status}">
                                            <c:if test="${order.status == 'pending'}">Chờ xác nhận</c:if>
                                            <c:if test="${order.status == 'confirmed'}">Đã xác nhận</c:if>
                                            <c:if test="${order.status == 'shipping'}">Đang giao</c:if>
                                            <c:if test="${order.status == 'delivered'}">Đã giao</c:if>
                                            <c:if test="${order.status == 'cancelled'}">Hủy</c:if>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="dropdown d-inline">
                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="fas fa-cog"></i> Thay đổi
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=pending">Chờ xác nhận</a></li>
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=confirmed">Đã xác nhận</a></li>
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=shipping">Đang giao</a></li>
                                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=delivered">Đã giao</a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/AdminController?action=updateOrderStatus&orderId=${order.id}&status=cancelled">Hủy đơn hàng</a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:useBean id="now" class="java.util.Date"/>
    <%@ include file="../common/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
