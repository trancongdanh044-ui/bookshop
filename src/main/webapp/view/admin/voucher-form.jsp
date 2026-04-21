<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty voucher ? 'Thêm voucher' : 'Cập nhật voucher'}</title>
    <link href="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/view/common/header.jsp"/>

    <div class="container py-4">
        <div class="card shadow-sm">
            <div class="card-body">
                <h1 class="h3 mb-4">${empty voucher ? 'Thêm voucher mới' : 'Cập nhật voucher'}</h1>

                <form action="${pageContext.request.contextPath}/AdminController" method="post">
                    <input type="hidden" name="action" value="${empty voucher ? 'addVoucher' : 'updateVoucher'}">
                    <c:if test="${not empty voucher}">
                        <input type="hidden" name="voucherId" value="${voucher.id}">
                    </c:if>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Mã voucher</label>
                            <input type="text" class="form-control" name="code" value="${voucher.code}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Giá trị giảm</label>
                            <input type="number" step="0.01" class="form-control" name="discount" value="${voucher.discount}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Loại</label>
                            <select class="form-select" name="type" required>
                                <option value="percent" ${voucher.type == 'percent' ? 'selected' : ''}>Phần trăm</option>
                                <option value="fixed" ${voucher.type == 'fixed' ? 'selected' : ''}>Số tiền cố định</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" class="form-control" name="quantity" value="${voucher.quantity}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Đơn tối thiểu</label>
                            <input type="number" step="0.01" class="form-control" name="minOrderValue" value="${voucher.minOrderValue}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Ngày bắt đầu</label>
                            <input type="date" class="form-control" name="startDate" value="${voucher.startDate}" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Ngày kết thúc</label>
                            <input type="date" class="form-control" name="endDate" value="${voucher.endDate}" required>
                        </div>
                    </div>

                    <div class="d-flex gap-2 mt-4">
                        <button type="submit" class="btn btn-primary">${empty voucher ? 'Lưu voucher' : 'Cập nhật voucher'}</button>
                        <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/AdminController?action=manageVouchers">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="/view/common/footer.jsp"/>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>
