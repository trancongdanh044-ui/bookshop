<%@ include file="../common/header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <section class="container mx-auto px-4 py-12">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">
            <i class="fa-solid fa-tag text-blue-600 mr-3"></i>Danh mục sách
        </h1>

        <!-- Add Category -->
        <div class="bg-white rounded-xl shadow-md p-6 mb-8">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Thêm danh mục mới</h2>
            <form class="flex gap-3">
                <input type="text" placeholder="Tên danh mục..." class="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                <input type="text" placeholder="Mô tả..." class="flex-1 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg font-medium hover:bg-blue-700 transition">
                    <i class="fa-solid fa-plus mr-2"></i>Thêm
                </button>
            </form>
        </div>

        <!-- Categories List -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Category 1 -->
            <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition">
                <h3 class="text-lg font-bold text-gray-800 mb-2">Văn học - Tiểu thuyết</h3>
                <p class="text-gray-600 text-sm mb-4">Các tác phẩm văn học kinh điển và hiện đại</p>
                <div class="flex items-center justify-between mb-4">
                    <span class="text-sm text-gray-600">Số sách: <span class="font-bold">48</span></span>
                    <i class="fa-solid fa-book-open text-2xl text-blue-600 opacity-50"></i>
                </div>
                <div class="flex gap-2">
                    <button class="flex-1 bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition text-sm font-medium">
                        <i class="fa-solid fa-pen-to-square mr-1"></i>Sửa
                    </button>
                    <button class="flex-1 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition text-sm font-medium">
                        <i class="fa-solid fa-trash mr-1"></i>Xóa
                    </button>
                </div>
            </div>

            <!-- Category 2 -->
            <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition">
                <h3 class="text-lg font-bold text-gray-800 mb-2">Kinh tế - Kinh doanh</h3>
                <p class="text-gray-600 text-sm mb-4">Sách về kinh tế, kinh doanh và quản lý</p>
                <div class="flex items-center justify-between mb-4">
                    <span class="text-sm text-gray-600">Số sách: <span class="font-bold">35</span></span>
                    <i class="fa-solid fa-chart-line text-2xl text-green-600 opacity-50"></i>
                </div>
                <div class="flex gap-2">
                    <button class="flex-1 bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition text-sm font-medium">
                        <i class="fa-solid fa-pen-to-square mr-1"></i>Sửa
                    </button>
                    <button class="flex-1 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition text-sm font-medium">
                        <i class="fa-solid fa-trash mr-1"></i>Xóa
                    </button>
                </div>
            </div>

            <!-- Category 3 -->
            <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition">
                <h3 class="text-lg font-bold text-gray-800 mb-2">Công nghệ - Lập trình</h3>
                <p class="text-gray-600 text-sm mb-4">Sách về công nghệ, lập trình và phát triển</p>
                <div class="flex items-center justify-between mb-4">
                    <span class="text-sm text-gray-600">Số sách: <span class="font-bold">52</span></span>
                    <i class="fa-solid fa-laptop-code text-2xl text-purple-600 opacity-50"></i>
                </div>
                <div class="flex gap-2">
                    <button class="flex-1 bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition text-sm font-medium">
                        <i class="fa-solid fa-pen-to-square mr-1"></i>Sửa
                    </button>
                    <button class="flex-1 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition text-sm font-medium">
                        <i class="fa-solid fa-trash mr-1"></i>Xóa
                    </button>
                </div>
            </div>

            <!-- Category 4 -->
            <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition">
                <h3 class="text-lg font-bold text-gray-800 mb-2">Tâm lý - Phát triển bản thân</h3>
                <p class="text-gray-600 text-sm mb-4">Sách về tâm lý học và phát triển kỹ năng</p>
                <div class="flex items-center justify-between mb-4">
                    <span class="text-sm text-gray-600">Số sách: <span class="font-bold">42</span></span>
                    <i class="fa-solid fa-brain text-2xl text-pink-600 opacity-50"></i>
                </div>
                <div class="flex gap-2">
                    <button class="flex-1 bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition text-sm font-medium">
                        <i class="fa-solid fa-pen-to-square mr-1"></i>Sửa
                    </button>
                    <button class="flex-1 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition text-sm font-medium">
                        <i class="fa-solid fa-trash mr-1"></i>Xóa
                    </button>
                </div>
            </div>

            <!-- Category 5 -->
            <div class="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition">
                <h3 class="text-lg font-bold text-gray-800 mb-2">Lịch sử - Địa lý</h3>
                <p class="text-gray-600 text-sm mb-4">Sách về lịch sử và địa lý thế giới</p>
                <div class="flex items-center justify-between mb-4">
                    <span class="text-sm text-gray-600">Số sách: <span class="font-bold">28</span></span>
                    <i class="fa-solid fa-globe text-2xl text-orange-600 opacity-50"></i>
                </div>
                <div class="flex gap-2">
                    <button class="flex-1 bg-blue-600 text-white py-2 rounded-lg hover:bg-blue-700 transition text-sm font-medium">
                        <i class="fa-solid fa-pen-to-square mr-1"></i>Sửa
                    </button>
                    <button class="flex-1 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition text-sm font-medium">
                        <i class="fa-solid fa-trash mr-1"></i>Xóa
                    </button>
                </div>
            </div>
        </div>
    </section>

<%@ include file="../common/footer.jsp" %>
