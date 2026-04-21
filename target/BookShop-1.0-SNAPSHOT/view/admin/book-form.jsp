<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty book ? 'Thêm sách' : 'Cập nhật sách'}</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <div class="card shadow-sm">
            <div class="card-body">
                <h1 class="h3 mb-4">${empty book ? 'Thêm sách mới' : 'Cập nhật sách'}</h1>

                <c:if test="${not empty bookError}">
                    <div class="alert alert-danger" role="alert">
                        ${bookError}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/AdminController" method="post">
                    <input type="hidden" name="action" value="${empty book ? 'addBook' : 'updateBook'}">
                    <c:if test="${not empty book}">
                        <input type="hidden" name="bookId" value="${book.id}">
                    </c:if>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Tên sách</label>
                            <input type="text" class="form-control" name="title" value="${book.title}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tác giả</label>
                            <input type="text" class="form-control" name="author" value="${book.author}" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Giá bán</label>
                            <input type="number" class="form-control" name="price" step="0.01" value="${book.price}" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Giảm giá trực tiếp</label>
                            <input type="number" class="form-control" name="discount" step="0.01" value="${book.discount}">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Số lượng tồn</label>
                            <input type="number" class="form-control" name="quantity" value="${book.quantity}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Danh mục</label>
                            <select class="form-select" name="categoryId" required>
                                <option value="">Chọn danh mục</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" ${not empty book && not empty book.category && book.category.id == category.id ? 'selected' : ''}>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tên file ảnh</label>
                            <input type="text" class="form-control" name="image" value="${book.image}">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="description" rows="4">${book.description}</textarea>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-4">
                        <button type="submit" class="btn btn-primary">${empty book ? 'Thêm sách' : 'Cập nhật'}</button>
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/AdminController?action=manageBooks">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
