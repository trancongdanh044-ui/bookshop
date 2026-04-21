<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookShop</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <div class="p-4 p-md-5 mb-4 bg-white border rounded-3 shadow-sm">
            <h1 class="display-6 fw-bold">Mua sách không cần đăng nhập</h1>
            <p class="lead mb-0">Khách có thể xem sách ngay trên trang chủ, thêm vào giỏ, mua ngay và thanh toán bằng form nhận hàng.</p>
        </div>

        <!-- Header row with title, category dropdown, and search -->
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-3">
            <div>
                <h2 class="h4 mb-0">Danh sách sách</h2>
                <small class="text-muted">Tìm thấy ${totalBooks} sản phẩm</small>
            </div>
            
            <div class="d-flex gap-2">
                <!-- Category Dropdown -->
                <form action="${pageContext.request.contextPath}/BookController" method="get" class="d-flex">
                    <select name="categoryId" class="form-select" style="width: auto;" onchange="this.form.submit()">
                        <option value=""> Tất cả danh mục</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.id}" ${selectedCategory == category.id ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </form>
                
                <!-- Search Form -->
                <form action="${pageContext.request.contextPath}/BookController" method="get" class="d-flex">
                    <input type="text" name="search" class="form-control form-control-sm me-2" 
                           placeholder="Tìm sách theo tên, tác giả ...." value="${search}" style="width: 400px;">
                    <input type="hidden" name="categoryId" value="${selectedCategory}">
                    <button type="submit" class="btn btn-primary btn-sm">Tìm</button>
                </form>
            </div>
        </div>

        <c:if test="${empty books}">
            <div class="alert alert-info">Không tìm thấy sách phù hợp.</div>
        </c:if>

        <div class="row g-4">
            <c:forEach var="book" items="${books}">
                <div class="col-sm-6 col-lg-4 col-xl-3">
                    <div class="card h-100 shadow-sm">
                        <c:choose>
                            <c:when test="${not empty book.image}">
                                <img src="${book.image}" class="card-img-top" alt="${book.title}" style="height: 260px; object-fit: cover;">
                            </c:when>
                            <c:otherwise>
                                <div class="card-img-top bg-secondary-subtle d-flex align-items-center justify-content-center" style="height: 260px;">
                                    <span class="text-muted">Chưa có ảnh</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="card-body d-flex flex-column">
                            <div class="small text-muted mb-1">${book.author}</div>
                            <h3 class="h6 card-title">${book.title}</h3>
                            <p class="small text-muted flex-grow-1">${book.description}</p>
                            <div class="mb-2">
                                <div class="fw-bold text-danger">
                                    <fmt:formatNumber value="${book.finalPrice}" pattern="#,##0"/>đ
                                </div>
                                <c:if test="${book.discount > 0}">
                                    <div class="small text-muted text-decoration-line-through">
                                        <fmt:formatNumber value="${book.price}" pattern="#,##0"/>đ
                                    </div>
                                </c:if>
                            </div>
                            <div class="mb-3">
                                <c:choose>
                                    <c:when test="${book.quantity > 0}">
                                        <span class="badge text-bg-success">Còn ${book.quantity} cuốn</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge text-bg-secondary">Hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="d-grid gap-2">
                                <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/BookController?action=detail&bookId=${book.id}">
                                    Xem chi tiết & Đánh giá
                                </a>
                                <c:if test="${book.quantity > 0}">
                                    <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/CartController?action=add&id=${book.id}">
                                        Thêm vào giỏ
                                    </a>
                                    <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/CartController?action=add&id=${book.id}&buyNow=1">
                                        Mua ngay
                                    </a>
                                </c:if>
                                <c:if test="${book.quantity <= 0}">
                                    <button class="btn btn-secondary btn-sm" disabled>Không thể mua</button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:forEach var="pageNo" begin="1" end="${totalPages}">
                        <li class="page-item ${pageNo == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/BookController?page=${pageNo}&search=${search}&categoryId=${selectedCategory}">${pageNo}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>