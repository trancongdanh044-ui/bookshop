<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - BookShop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .input-focus:focus { @apply ring-2 ring-blue-400; }
        .login-card { box-shadow: 0 10px 40px rgba(0,0,0,0.1); }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-50 to-indigo-100 min-h-screen flex items-center justify-center">
    <div class="w-full max-w-md">
        <!-- Logo -->
        <div class="text-center mb-8">
            <a href="<%=request.getContextPath()%>" class="inline-flex items-center gap-2 text-3xl font-bold text-blue-600 hover:text-blue-700 transition">
                <i class="fa-solid fa-book-open"></i> BookShop
            </a>
            <p class="text-gray-600 mt-2">Cửa hàng sách trực tuyến hàng đầu</p>
        </div>

        <!-- Login Form -->
        <div class="bg-white rounded-xl login-card p-8">
            <h1 class="text-2xl font-bold text-gray-800 mb-2">Đăng nhập</h1>
            <p class="text-gray-500 mb-6">Đăng nhập để truy cập tài khoản của bạn</p>

            <% String error = (String) request.getAttribute("error"); %>
            <% String success = (String) request.getAttribute("success"); %>
            
            <% if (error != null && !error.isEmpty()) { %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-4 flex items-center gap-2">
                    <i class="fa-solid fa-exclamation-circle"></i>
                    <%= error %>
                </div>
            <% } %>
            
            <% if (success != null && !success.isEmpty()) { %>
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded-lg mb-4 flex items-center gap-2">
                    <i class="fa-solid fa-check-circle"></i>
                    <%= success %>
                </div>
            <% } %>

            <form action="<%=request.getContextPath()%>/AuthController" method="POST">
                <input type="hidden" name="action" value="login">

                <!-- Username -->
                <div class="mb-4">
                    <label for="username" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-user mr-2 text-blue-600"></i>Tên đăng nhập
                    </label>
                    <input type="text" id="username" name="username" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="Nhap ten dang nhap">
                </div>

                <!-- Password -->
                <div class="mb-6">
                    <label for="password" class="block text-gray-700 font-medium mb-2">
                        <i class="fa-solid fa-lock mr-2 text-blue-600"></i>Mật khẩu
                    </label>
                    <input type="password" id="password" name="password" required
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg input-focus outline-none transition"
                           placeholder="........">
                </div>

                <!-- Remember & Forgot Password -->
                <div class="flex items-center justify-between mb-6">
                    <label class="flex items-center gap-2 text-gray-700">
                        <input type="checkbox" name="remember" class="w-4 h-4 rounded">
                        <span class="text-sm">Ghi nhớ tôi</span>
                    </label>
                    <a href="#" class="text-blue-600 hover:text-blue-700 text-sm font-medium transition">Quen mat khau?</a>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="w-full bg-gradient-to-r from-blue-600 to-blue-700 text-white font-bold py-2 rounded-lg hover:shadow-lg transition mb-4">
                    <i class="fa-solid fa-sign-in-alt mr-2"></i>Đăng nhập
                </button>

                <!-- Divider -->
<!--                <div class="relative mb-4">
                    <div class="absolute inset-0 flex items-center">
                        <div class="w-full border-t border-gray-300"></div>
                    </div>
                    <div class="relative flex justify-center text-sm">
                        <span class="px-2 bg-white text-gray-500">Hoặc</span>
                    </div>
                </div>

                 Social Login (Optional) 
                <div class="grid grid-cols-2 gap-3 mb-6">
                    <button type="button" class="flex items-center justify-center gap-2 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
                        <i class="fa-brands fa-google text-red-500"></i>
                        <span class="text-sm">Google</span>
                    </button>
                    <button type="button" class="flex items-center justify-center gap-2 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
                        <i class="fa-brands fa-facebook text-blue-600"></i>
                        <span class="text-sm">Facebook</span>
                    </button>
                </div>
            </form>-->

            <!-- Sign Up Link -->
            <p class="text-center text-gray-600">
                Chưa có tài khoản? 
                <a href="<%=request.getContextPath()%>/AuthController?action=register" class="text-blue-600 hover:text-blue-700 font-bold transition">Đăng ký ngay</a>
            </p>
        </div>

        <!-- Footer -->
        <div class="text-center mt-6 text-gray-500 text-sm">
            <p>&copy; 2026 BookShop - Cửa hàng sách trực tuyến</p>
        </div>
    </div>
</body>
</html>
