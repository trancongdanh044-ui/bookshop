<%@ include file="../common/header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <section class="container mx-auto px-4 py-12">
        <h1 class="text-3xl font-bold text-gray-800 mb-8">
            <i class="fa-solid fa-user-circle text-blue-600 mr-3"></i>Hồ sơ cá nhân
        </h1>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <!-- Sidebar -->
            <div class="lg:col-span-1">
                <div class="bg-white rounded-xl shadow-md p-6 sticky top-24">
                    <div class="text-center mb-6">
                        <img src="https://ui-avatars.com/api/?name=Nguyen+Van+A&size=128&background=random" alt="Avatar" class="w-24 h-24 rounded-full mx-auto mb-4 border-4 border-blue-600">
                        <h3 class="text-xl font-bold text-gray-800">Nguyễn Văn A</h3>
                        <p class="text-gray-600 text-sm">Thành viên từ 2026</p>
                    </div>

                    <hr class="my-4">

                    <nav class="space-y-2">
                        <a href="#" class="block px-4 py-2 bg-blue-50 text-blue-600 rounded-lg font-medium">
                            <i class="fa-solid fa-user mr-2"></i>Thông tin cá nhân
                        </a>
                        <a href="#" class="block px-4 py-2 text-gray-700 hover:bg-gray-50 rounded-lg transition">
                            <i class="fa-solid fa-lock mr-2"></i>Đổi mật khẩu
                        </a>
                        <a href="#" class="block px-4 py-2 text-gray-700 hover:bg-gray-50 rounded-lg transition">
                            <i class="fa-solid fa-map-marker-alt mr-2"></i>Địa chỉ
                        </a>
                        <a href="#" class="block px-4 py-2 text-gray-700 hover:bg-gray-50 rounded-lg transition">
                            <i class="fa-solid fa-heart mr-2"></i>Sản phẩm yêu thích
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Main Content -->
            <div class="lg:col-span-2">
                <!-- Personal Information -->
                <div class="bg-white rounded-xl shadow-md p-6 mb-6">
                    <h2 class="text-2xl font-bold text-gray-800 mb-6 flex items-center gap-2">
                        <i class="fa-solid fa-info-circle text-blue-600"></i> Thông tin cá nhân
                    </h2>

                    <form class="space-y-4">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-gray-700 font-medium mb-2">Họ và tên *</label>
                                <input type="text" value="Nguyễn Văn A" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                            </div>
                            <div>
                                <label class="block text-gray-700 font-medium mb-2">Email *</label>
                                <input type="email" value="nguyenvana@example.com" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-gray-700 font-medium mb-2">Số điện thoại *</label>
                                <input type="tel" value="0912345678" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                            </div>
                            <div>
                                <label class="block text-gray-700 font-medium mb-2">Ngày sinh</label>
                                <input type="date" value="1990-01-01" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                            </div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-gray-700 font-medium mb-2">Giới tính</label>
                                <select class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                                    <option>Nam</option>
                                    <option>Nữ</option>
                                    <option>Khác</option>
                                </select>
                            </div>
                            <div>
                                <label class="block text-gray-700 font-medium mb-2">Quốc tịch</label>
                                <input type="text" value="Việt Nam" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                            </div>
                        </div>

                        <div>
                            <label class="block text-gray-700 font-medium mb-2">Địa chỉ *</label>
                            <input type="text" value="123 Đường ABC, Quận Hai Bà Trưng, Hà Nội" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400">
                        </div>

                        <div>
                            <label class="flex items-center gap-2">
                                <input type="checkbox" checked class="w-4 h-4 rounded">
                                <span class="text-gray-700">Nhận email thông báo về khuyến mãi và sản phẩm mới</span>
                            </label>
                        </div>

                        <div class="flex gap-3 pt-4">
                            <button type="submit" class="px-6 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition">
                                <i class="fa-solid fa-save mr-2"></i>Lưu thay đổi
                            </button>
                            <button type="reset" class="px-6 py-2 border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition">
                                <i class="fa-solid fa-redo mr-2"></i>Hủy
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Membership Status -->
                <div class="bg-gradient-to-r from-purple-500 to-indigo-600 rounded-xl shadow-md p-6 text-white">
                    <h3 class="text-xl font-bold mb-4">
                        <i class="fa-solid fa-crown mr-2"></i>Thành viên VIP
                    </h3>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
                        <div class="bg-white/20 rounded-lg p-3">
                            <p class="text-2xl font-bold">2.150.000đ</p>
                            <p class="text-sm opacity-90">Tổng chi tiêu</p>
                        </div>
                        <div class="bg-white/20 rounded-lg p-3">
                            <p class="text-2xl font-bold">25</p>
                            <p class="text-sm opacity-90">Điểm thưởng</p>
                        </div>
                        <div class="bg-white/20 rounded-lg p-3">
                            <p class="text-2xl font-bold">12</p>
                            <p class="text-sm opacity-90">Đơn hàng</p>
                        </div>
                        <div class="bg-white/20 rounded-lg p-3">
                            <p class="text-2xl font-bold">5</p>
                            <p class="text-sm opacity-90">Bình luận</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

<%@ include file="../common/footer.jsp" %>
