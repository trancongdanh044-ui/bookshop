<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sách</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 mb-0">Quản lý sách</h1>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/AdminController?action=addBook">Thêm sách mới</a>
        </div>

        <c:if test="${not empty bookSuccess}">
            <div class="alert alert-success" role="alert">
                ${bookSuccess}
            </div>
        </c:if>

        <c:if test="${not empty bookError}">
            <div class="alert alert-danger" role="alert">
                ${bookError}
            </div>
        </c:if>

        <div class="card shadow-sm">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên sách</th>
                                <th>Tác giả</th>
                                <th>Giá bán</th>
                                <th>Giảm giá</th>
                                <th>Giá sau giảm</th>
                                <th>Tồn kho</th>
                                <th>Danh mục</th>
                                <th class="text-end">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td>${book.id}</td>
                                    <td>${book.title}</td>
                                    <td>${book.author}</td>
                                    <td><fmt:formatNumber value="${book.price}" pattern="#,##0"/>đ</td>
                                    <td><fmt:formatNumber value="${book.discount}" pattern="#,##0"/>đ</td>
                                    <td><fmt:formatNumber value="${book.finalPrice}" pattern="#,##0"/>đ</td>
                                    <td>${book.quantity}</td>
                                    <td>${book.category != null ? book.category.name : ''}</td>
                                    <td class="text-end">
                                        <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/AdminController?action=editBook&bookId=${book.id}">Sửa</a>
                                        <a class="btn btn-outline-danger btn-sm" href="${pageContext.request.contextPath}/AdminController?action=deleteBook&bookId=${book.id}" onclick="return confirm('Xóa sách này?');">Xóa</a>
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
