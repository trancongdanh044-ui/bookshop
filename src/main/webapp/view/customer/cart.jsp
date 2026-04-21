<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng của bạn | BookShop</title>
        <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/style.css">

        <style>
            body { background-color: #f8f9fa; }
            
            /* --- CSS ẢNH SÁCH --- */
            .cart-image {
                width: 70px;
                height: 90px;
                object-fit: cover;
                border-radius: 6px;
                border: 1px solid #e9ecef;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                transition: transform 0.2s;
            }
            .cart-image:hover {
                transform: scale(1.05);
            }
            .book-title {
                color: #2b3445;
                text-decoration: none;
                transition: color 0.2s ease;
            }
            .book-title:hover {
                color: #0d6efd;
            }

            /* --- CSS Ô SỐ LƯỢNG --- */
            .custom-qty-group {
                display: flex;
                flex-wrap: nowrap;
                width: 80px; /* Đã nới nhẹ lên 95px để mũi tên có chỗ đứng */
                margin: 0 auto;
            }
            .custom-qty-group input {
                border-top-right-radius: 0 !important;
                border-bottom-right-radius: 0 !important;
                border-right: 0 !important;
                font-weight: 500;
                /* Chỉnh padding bên phải hẹp lại nhường chỗ cho mũi tên */
                padding: 0.25rem 0.1rem 0.25rem 0.5rem; 
            }
            .custom-qty-group button {
                border-top-left-radius: 0 !important;
                border-bottom-left-radius: 0 !important;
                margin-left: 0 !important;
                background-color: #f8f9fa;
                transition: background-color 0.2s;
                padding: 0.25rem 0.5rem;
            }
            .custom-qty-group button:hover {
                background-color: #e9ecef;
            }

            /* --- CSS NÚT XÓA HIỆN ĐẠI --- */
            .btn-delete-modern {
                color: #dc3545;
                background-color: #fff5f5; 
                border: 1px solid #ffe6e6;
                border-radius: 8px;
                padding: 8px 16px;
                font-size: 0.9rem;
                font-weight: 600;
                transition: all 0.2s ease;
                white-space: nowrap;
            }
            .btn-delete-modern:hover {
                background-color: #dc3545; 
                color: #ffffff;
                box-shadow: 0 4px 10px rgba(220, 53, 69, 0.25);
                transform: translateY(-2px);
            }

            /* --- CSS NÚT THANH TOÁN TÓM TẮT --- */
            .btn-checkout-modern {
                background: linear-gradient(45deg, #0d6efd, #0b5ed7); 
                border: none;
                box-shadow: 0 4px 12px rgba(13, 110, 253, 0.3);
                transition: all 0.3s ease;
            }
            .btn-checkout-modern:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(13, 110, 253, 0.45);
            }
            
            /* Icon giỏ hàng trống */
            .empty-cart-icon {
                font-size: 80px;
                color: #dee2e6;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/view/common/header.jsp"/>

        <div class="container py-5 mb-5">
            <h2 class="fw-bold mb-4 text-dark"><i class="fas fa-shopping-cart text-primary me-2"></i>Giỏ hàng của bạn</h2>

            <c:if test="${empty sessionScope.cart}">
                <div class="card shadow-sm border-0 py-5 text-center" style="border-radius: 12px;">
                    <div class="card-body py-5">
                        <i class="fas fa-box-open empty-cart-icon"></i>
                        <h4 class="text-dark fw-bold mb-3">Giỏ hàng trống</h4>
                        <p class="text-muted mb-4 fs-5">Hãy tham khảo thêm các tựa sách hấp dẫn nhé!</p>
                        <a href="${pageContext.request.contextPath}/BookController" class="btn btn-primary px-5 py-2 rounded-pill fw-bold fs-5 shadow-sm">
                            Đi mua sắm ngay
                        </a>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.cart}">
                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="card shadow-sm border-0" style="border-radius: 12px; overflow: hidden;">
                            <div class="card-body p-0">
                                <div class="table-responsive">
                                    <table class="table table-hover align-top mb-0">
                                        <thead class="table-light align-middle">
                                            <tr>
                                                <th class="ps-4 text-secondary text-uppercase text-nowrap" style="width: 45%; font-size: 0.85rem; padding-top: 15px; padding-bottom: 15px;">Sản phẩm</th>
                                                <th class="text-center text-secondary text-uppercase text-nowrap" style="width: 15%; font-size: 0.85rem;">Đơn giá</th>
                                                <th class="text-center text-secondary text-uppercase text-nowrap" style="width: 15%; font-size: 0.85rem;">Số lượng</th>
                                                <th class="text-center text-secondary text-uppercase text-nowrap" style="width: 15%; font-size: 0.85rem;">Thành tiền</th>
                                                <th class="text-center text-secondary text-uppercase text-nowrap" style="width: 10%; font-size: 0.85rem;">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="totalPrice" value="0"/>
                                            <c:forEach var="item" items="${sessionScope.cart}">
                                                <c:set var="itemTotal" value="${item.book.finalPrice * item.quantity}"/>
                                                <c:set var="totalPrice" value="${totalPrice + itemTotal}"/>

                                                <tr>
                                                    <td class="ps-4 py-4">
                                                        <div class="d-flex align-items-start gap-3">
                                                            <a href="${pageContext.request.contextPath}/BookController?action=detail&bookId=${item.book.id}" class="flex-shrink-0">
                                                                <img src="${pageContext.request.contextPath}/assets/images/${item.book.image}" alt="${item.book.title}" class="cart-image" onerror="this.src='https://via.placeholder.com/70x90?text=No+Image'">
                                                            </a>
                                                            
                                                            <div class="pt-1">
                                                                <a href="${pageContext.request.contextPath}/BookController?action=detail&bookId=${item.book.id}" class="fw-bold book-title d-block mb-1" style="max-width: 200px; font-size: 1.05rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                                    ${item.book.title}
                                                                </a>
                                                                <div class="small text-muted"><i class="fas fa-pen-nib me-1"></i>${item.book.author}</div>
                                                            </div>
                                                        </div>
                                                    </td>

                                                    <td class="text-center py-4">
                                                        <div class="pt-1">
                                                            <div class="text-danger fw-bold"><fmt:formatNumber value="${item.book.finalPrice}" pattern="#,##0"/> đ</div>
                                                            <c:if test="${item.book.discount > 0}">
                                                                <div class="small text-muted text-decoration-line-through mt-1"><fmt:formatNumber value="${item.book.price}" pattern="#,##0"/> đ</div>
                                                            </c:if>
                                                        </div>
                                                    </td>

                                                    <td class="text-center py-4">
                                                        <form action="${pageContext.request.contextPath}/CartController" method="get" class="m-0">
                                                            <input type="hidden" name="action" value="update">
                                                            <input type="hidden" name="id" value="${item.book.id}">

                                                            <div class="custom-qty-group shadow-sm" style="border-radius: 6px;">
                                                                <input type="number" min="1" max="${item.book.quantity}" name="quantity" value="${item.quantity}" class="form-control text-center shadow-none border-secondary" style="border-radius: 6px 0 0 6px;">
                                                                <button class="btn border border-secondary" type="submit" title="Cập nhật" style="border-radius: 0 6px 6px 0;">
                                                                    <i class="fas fa-sync-alt text-secondary"></i>
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </td>

                                                    <td class="fw-bold text-dark text-center fs-6 py-4">
                                                        <div class="pt-1">
                                                            <fmt:formatNumber value="${itemTotal}" pattern="#,##0"/> đ
                                                        </div>
                                                    </td>

                                                    <td class="text-center py-4">
                                                        <a class="btn-delete-modern text-decoration-none d-inline-block" href="${pageContext.request.contextPath}/CartController?action=remove&id=${item.book.id}" title="Xóa khỏi giỏ">
                                                            <i class="fas fa-trash-alt me-1"></i> Xóa
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card shadow-sm border-0 sticky-top" style="border-radius: 12px; top: 100px;">
                            <div class="card-body p-4">
                                <h5 class="fw-bold mb-4 text-dark">Tóm tắt đơn hàng</h5>

                                <div class="d-flex justify-content-between mb-3 text-muted">
                                    <span>Tổng số lượng sách:</span>
                                    <strong class="text-dark">${sessionScope.cartCount} cuốn</strong>
                                </div>

                                <hr class="text-muted opacity-25">

                                <div class="d-flex justify-content-between mb-4 align-items-center">
                                    <span class="fw-bold fs-5 text-dark">Tạm tính:</span>
                                    <span class="fw-bold fs-4 text-danger"><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/> đ</span>
                                </div>

                                <div class="mt-4">
                                    <a class="btn btn-primary btn-checkout-modern btn-lg w-100 fw-bold mb-3" href="${pageContext.request.contextPath}/OrderController?action=checkout" style="border-radius: 8px;">
                                        Tiến hành thanh toán <i class="fas fa-arrow-right ms-2"></i>
                                    </a>

                                    <a class="btn btn-light border w-100 fw-semibold mb-3 py-2 text-dark" href="${pageContext.request.contextPath}/BookController" style="border-radius: 8px; transition: background-color 0.2s;">
                                        <i class="fas fa-arrow-left me-2 text-muted"></i> Tiếp tục mua hàng
                                    </a>

                                    <div class="text-center mt-2">
                                        <a class="text-danger text-decoration-none small fw-semibold opacity-75 hover-opacity-100" href="${pageContext.request.contextPath}/CartController?action=clear" onclick="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');">
                                            <i class="fas fa-times-circle me-1"></i> Xóa toàn bộ giỏ hàng
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <jsp:include page="/view/common/footer.jsp"/>
        <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
    </body>
</html>