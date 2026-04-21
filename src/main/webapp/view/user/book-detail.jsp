<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title}</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <c:choose>
                        <c:when test="${not empty book.image}">
                            <img src="${book.image}" class="card-img-top" alt="${book.title}">
                        </c:when>
                        <c:otherwise>
                            <div class="card-img-top bg-secondary-subtle d-flex align-items-center justify-content-center" style="height: 420px;">
                                <span class="text-muted">Chưa có ảnh</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="small text-muted mb-2">${book.category != null ? book.category.name : ''}</div>
                        <h1 class="h3">${book.title}</h1>
                        <div class="mb-3 text-muted">Tác giả: ${book.author}</div>
                        <div class="mb-3">
                            <span class="h3 text-danger"><fmt:formatNumber value="${book.finalPrice}" pattern="#,##0"/>đ</span>
                            <c:if test="${book.discount > 0}">
                                <span class="text-muted text-decoration-line-through ms-2"><fmt:formatNumber value="${book.price}" pattern="#,##0"/>đ</span>
                                <span class="badge text-bg-danger ms-2">Giảm <fmt:formatNumber value="${book.discount}" pattern="#,##0"/>đ</span>
                            </c:if>
                        </div>
                        <div class="mb-3">
                            <span class="badge ${book.quantity > 0 ? 'text-bg-success' : 'text-bg-secondary'}">
                                ${book.quantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                            </span>
                            <span class="ms-2 text-muted">Đã có ${reviewCount} đánh giá</span>
                        </div>
                        <p class="mb-4">${book.description}</p>

                        <c:if test="${book.quantity > 0}">
                            <div class="d-flex gap-2">
                                <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/CartController?action=add&id=${book.id}">Thêm vào giỏ</a>
                                <a class="btn btn-primary" href="${pageContext.request.contextPath}/CartController?action=add&id=${book.id}&buyNow=1">Mua ngay</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4 mt-1">
            <div class="col-lg-7">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="h5 mb-3">Đánh giá sách</h2>

                        <c:if test="${not empty reviewError}">
                            <div class="alert alert-danger">${reviewError}</div>
                        </c:if>
                        <c:if test="${not empty reviewSuccess}">
                            <div class="alert alert-success">${reviewSuccess}</div>
                        </c:if>

                        <c:if test="${canReview}">
                            <form action="${pageContext.request.contextPath}/ReviewController" method="post" class="mb-4">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <div class="mb-3">
                                    <label class="form-label">Số sao</label>
                                    <select class="form-select" name="rating" required>
                                        <option value="5">5 sao</option>
                                        <option value="4">4 sao</option>
                                        <option value="3">3 sao</option>
                                        <option value="2">2 sao</option>
                                        <option value="1">1 sao</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Nhận xét</label>
                                    <textarea class="form-control" name="comment" rows="4" required></textarea>
                                </div>
                                <button class="btn btn-primary" type="submit">Gửi đánh giá</button>
                            </form>
                        </c:if>

                        <c:if test="${empty reviews}">
                            <div class="text-muted">Chưa có đánh giá nào.</div>
                        </c:if>

                        <c:forEach var="review" items="${reviews}">
                            <div class="border-top pt-3 mt-3">
                                <div class="d-flex justify-content-between">
                                    <strong>${review.user.username}</strong>
                                    <span class="badge text-bg-warning">${review.rating}/5</span>
                                </div>
                                <div class="mt-2">${review.comment}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
