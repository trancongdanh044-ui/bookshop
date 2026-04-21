<%-- 
    Document   : register
    Created on : Apr 13, 2026, 8:48:19 PM
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - BookShop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .input-focus:focus { @apply ring-2 ring-blue-400; }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen flex items-center justify-center py-8">
    <div class="w-full max-w-md">
        <!-- Header -->
        <div class="text-center mb-8">
            <a href="<%=request.getContextPath()%>" class="inline-flex items-center gap-2 text-3xl font-bold text-blue-600 hover:text-blue-700 transition">
                <i class="fa-solid fa-book-open"></i> BookShop
            </a>
            <p class="text-gray-600 mt-2">Tạo tài khoản mới</p>
        </div>

        <!-- Registration Form -->
        <div class="bg-white rounded-xl shadow-lg p-8">
            <h1 class="text-2xl font-bold text-gray-800 mb-6">Đăng ký tài khoản</h1>

            <form action="<%=request.getContextPath()%>/AuthController" method="POST">
                <input type="hidden" name="action" value="register">

                <!-- Username -->
                <div class="mb-4">
                    <label for="username" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-user mr-2 text-blue-600"></i>Tên đăng nhập
                    </label>
                    <input type="text" id="username" name="username" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="username">
                </div>

                <!-- Full Name -->
                <div class="mb-4">
                    <label for="fullName" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-user mr-2 text-blue-600"></i>Họ và tên
                    </label>
                    <input type="text" id="fullName" name="fullName" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="Nguyễn Văn A">
                </div>

                <!-- Email -->
                <div class="mb-4">
                    <label for="email" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-envelope mr-2 text-blue-600"></i>Email
                    </label>
                    <input type="email" id="email" name="email" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="your@email.com">
                </div>

                <!-- Phone -->
                <div class="mb-4">
                    <label for="phone" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-phone mr-2 text-blue-600"></i>Số điện thoại
                    </label>
                    <input type="tel" id="phone" name="phone" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="0912345678">
                </div>

                <!-- Address -->
                <div class="mb-4">
                    <label for="address" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-map-marker-alt mr-2 text-blue-600"></i>Địa chỉ
                    </label>
                    <input type="text" id="address" name="address" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="123 Đường ABC, Hà Nội">
                </div>

                <!-- Password -->
                <div class="mb-4">
                    <label for="password" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-lock mr-2 text-blue-600"></i>Mật khẩu
                    </label>
                    <input type="password" id="password" name="password" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="Ít nhất 6 ký tự">
                    <small class="text-gray-500 mt-1 block">Mật khẩu phải dài ít nhất 6 ký tự</small>
                </div>

                <!-- Confirm Password -->
                <div class="mb-6">
                    <label for="confirmPassword" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-lock mr-2 text-blue-600"></i>Xác nhận mật khẩu
                    </label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="Nhập lại mật khẩu">
                </div>

                <!-- Terms Agreement -->
                <div class="mb-6">
                    <label class="flex items-start gap-2 cursor-pointer">
                        <input type="checkbox" name="agree" required class="w-4 h-4 rounded mt-1">
                        <span class="text-gray-700 text-sm">
                            Tôi đồng ý với 
                            <a href="#" class="text-blue-600 hover:underline">điều khoản sử dụng</a> 
                            và 
                            <a href="#" class="text-blue-600 hover:underline">chính sách bảo mật</a>
                        </span>
                    </label>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="w-full bg-gradient-to-r from-blue-600 to-blue-700 text-white font-bold py-2 rounded-lg hover:shadow-lg transition">
                    <i class="fa-solid fa-user-plus mr-2"></i>Tạo tài khoản
                </button>
            </form>

            <!-- Login Link -->
            <p class="text-center text-gray-600 mt-6">
                Đã có tài khoản? 
                <a href="<%=request.getContextPath()%>/AuthController?action=login" class="text-blue-600 hover:text-blue-700 font-bold transition">Đăng nhập</a>
            </p>
        </div>
    </div>
</body>
</html>
