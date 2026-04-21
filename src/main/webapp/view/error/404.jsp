<%@ include file="../common/header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <section class="container mx-auto px-4 py-12">
        <h1 class="text-4xl font-bold text-gray-800 mb-4">
            <i class="fa-solid fa-circle-exclamation text-red-500 mr-3"></i>404 - Trang không tìm thấy
        </h1>
        <p class="text-xl text-gray-600 mb-8">Trang bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>

        <div class="bg-white rounded-xl shadow-md p-8 text-center max-w-md mx-auto">
            <img src="https://via.placeholder.com/200x150?text=Not+Found" alt="404" class="w-40 h-40 mx-auto mb-6 object-cover rounded-lg">
            
            <h2 class="text-2xl font-bold text-gray-800 mb-4">Oops! Trang không tìm thấy</h2>
            <p class="text-gray-600 mb-6">
                Trang bạn đang tìm kiếm có thể đã bị xóa, tên đã thay đổi hoặc tạm thời không khả dụng.
            </p>

            <div class="flex gap-3">
                <a href="<%=request.getContextPath()%>/view/customer/home.jsp" class="flex-1 bg-blue-600 text-white font-bold py-2 rounded-lg hover:bg-blue-700 transition">
                    <i class="fa-solid fa-home mr-2"></i>Trang chủ
                </a>
                <button class="flex-1 border-2 border-gray-300 text-gray-700 font-bold py-2 rounded-lg hover:bg-gray-50 transition" onclick="window.history.back()">
                    <i class="fa-solid fa-arrow-left mr-2"></i>Quay lại
                </button>
            </div>
        </div>
    </section>

<%@ include file="../common/footer.jsp" %>
