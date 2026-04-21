<%-- 
    Document   : profile
    Created on : Apr 8, 2026, 7:44:01 AM
    Author     : lenovo
--%>

<%@ include file="../common/header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookShop - Mua sách trực tuyến</title>
    <!-- Tích hợp Tailwind CSS qua CDN để tạo giao diện nhanh -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Tích hợp FontAwesome cho các icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS tuỳ chỉnh ẩn/hiện các trang */
        .view-section { display: none; }
        .view-section.active { display: block; }
        .book-card:hover { transform: translateY(-5px); transition: all 0.3s ease; }
    </style>
    </head>
    <body class="bg-gray-50 font-sans text-gray-800 flex flex-col min-h-screen">
<main class="flex-grow container mx-auto px-4 py-8">

        <!-- =================== TRANG CHỦ (home.jsp) =================== -->
        <div id="home" class="view-section active">
            <!-- Banner Khuyến mãi -->
            <div class="bg-gradient-to-r from-blue-500 to-indigo-600 rounded-2xl p-8 text-white mb-8 shadow-lg flex items-center justify-between">
                <div>
                    <h1 class="text-4xl font-bold mb-2">Đại tiệc sách 2026</h1>
                    <p class="text-lg opacity-90 mb-4">Giảm giá lên đến 50% cho các đầu sách bán chạy nhất.</p>
                    <button class="bg-white text-blue-600 px-6 py-2 rounded-full font-bold hover:bg-gray-100 transition shadow-md">Mua ngay</button>
                </div>
                <div class="hidden md:block text-8xl opacity-80">
                    <i class="fa-solid fa-book-reader"></i>
                </div>
            </div>

            <div class="flex flex-col md:flex-row gap-8">
                <!-- Sidebar Danh mục (Bên trái) -->
                <aside class="w-full md:w-1/4">
                    <div class="bg-white rounded-xl shadow-sm p-5 border border-gray-100">
                        <h3 class="text-lg font-bold text-gray-800 border-b pb-3 mb-3"><i class="fa-solid fa-list mr-2 text-blue-600"></i> Danh Mục Sách</h3>
                        <ul class="space-y-2">
                            <li><a href="#" class="block text-gray-600 hover:text-blue-600 hover:bg-blue-50 px-3 py-2 rounded transition font-medium text-blue-600 bg-blue-50">Tất cả</a></li>
                            <li><a href="#" class="block text-gray-600 hover:text-blue-600 hover:bg-blue-50 px-3 py-2 rounded transition">Văn học - Tiểu thuyết</a></li>
                            <li><a href="#" class="block text-gray-600 hover:text-blue-600 hover:bg-blue-50 px-3 py-2 rounded transition">Kinh tế - Khởi nghiệp</a></li>
                            <li><a href="#" class="block text-gray-600 hover:text-blue-600 hover:bg-blue-50 px-3 py-2 rounded transition">Tâm lý - Kỹ năng sống</a></li>
                            <li><a href="#" class="block text-gray-600 hover:text-blue-600 hover:bg-blue-50 px-3 py-2 rounded transition">Khoa học - Công nghệ</a></li>
                        </ul>
                    </div>
                </aside>

                <!-- Grid Danh sách Sản phẩm (Bên phải) -->
                <div class="w-full md:w-3/4">
                    <div class="flex justify-between items-center mb-6">
                        <h2 class="text-2xl font-bold text-gray-800">Sách Mới Nổi Bật</h2>
                        <select class="border rounded-md px-3 py-1.5 text-sm text-gray-600 focus:outline-none focus:ring-1 focus:ring-blue-500">
                            <option>Sắp xếp: Mới nhất</option>
                            <option>Giá: Thấp đến cao</option>
                            <option>Giá: Cao đến thấp</option>
                        </select>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                        <!-- Sách 1 -->
                        <div class="book-card bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col">
                            <div class="h-64 overflow-hidden relative">
                                <span class="absolute top-2 right-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded">-10%</span>
                                <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=400&q=80" alt="Nhà Giả Kim" class="w-full h-full object-cover">
                            </div>
                            <div class="p-4 flex flex-col flex-grow">
                                <span class="text-xs text-blue-500 font-semibold mb-1">Văn học</span>
                                <h3 class="font-bold text-gray-800 mb-1 line-clamp-2">Nhà Giả Kim</h3>
                                <p class="text-sm text-gray-500 mb-2">Paulo Coelho</p>
                                <div class="mt-auto flex items-center justify-between pt-3">
                                    <div>
                                        <span class="text-lg font-bold text-red-600">75.000đ</span>
                                        <span class="text-xs text-gray-400 line-through ml-1">85.000đ</span>
                                    </div>
                                    <button class="bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white w-10 h-10 rounded-full flex items-center justify-center transition">
                                        <i class="fa-solid fa-cart-plus"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Sách 2 -->
                        <div class="book-card bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col">
                            <div class="h-64 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73?auto=format&fit=crop&w=400&q=80" alt="Đắc Nhân Tâm" class="w-full h-full object-cover">
                            </div>
                            <div class="p-4 flex flex-col flex-grow">
                                <span class="text-xs text-blue-500 font-semibold mb-1">Tâm lý - Kỹ năng</span>
                                <h3 class="font-bold text-gray-800 mb-1 line-clamp-2">Đắc Nhân Tâm</h3>
                                <p class="text-sm text-gray-500 mb-2">Dale Carnegie</p>
                                <div class="mt-auto flex items-center justify-between pt-3">
                                    <span class="text-lg font-bold text-red-600">80.000đ</span>
                                    <button class="bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white w-10 h-10 rounded-full flex items-center justify-center transition">
                                        <i class="fa-solid fa-cart-plus"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Sách 3 -->
                        <div class="book-card bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col">
                            <div class="h-64 overflow-hidden relative">
                                <span class="absolute top-2 left-2 bg-yellow-400 text-xs font-bold px-2 py-1 rounded text-gray-800">Best Seller</span>
                                <img src="https://images.unsplash.com/photo-1555662100-6090d1fe59e5?auto=format&fit=crop&w=400&q=80" alt="Clean Code" class="w-full h-full object-cover">
                            </div>
                            <div class="p-4 flex flex-col flex-grow">
                                <span class="text-xs text-blue-500 font-semibold mb-1">Công nghệ thông tin</span>
                                <h3 class="font-bold text-gray-800 mb-1 line-clamp-2">Clean Code - Mã Sạch</h3>
                                <p class="text-sm text-gray-500 mb-2">Robert C. Martin</p>
                                <div class="mt-auto flex items-center justify-between pt-3">
                                    <span class="text-lg font-bold text-red-600">250.000đ</span>
                                    <button class="bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white w-10 h-10 rounded-full flex items-center justify-center transition">
                                        <i class="fa-solid fa-cart-plus"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Sách 4 -->
                        <div class="book-card bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden flex flex-col">
                            <div class="h-64 overflow-hidden">
                                <img src="https://images.unsplash.com/photo-1592496431122-2349e0fbc666?auto=format&fit=crop&w=400&q=80" alt="Cha Giàu Cha Nghèo" class="w-full h-full object-cover">
                            </div>
                            <div class="p-4 flex flex-col flex-grow">
                                <span class="text-xs text-blue-500 font-semibold mb-1">Kinh tế</span>
                                <h3 class="font-bold text-gray-800 mb-1 line-clamp-2">Cha Giàu Cha Nghèo</h3>
                                <p class="text-sm text-gray-500 mb-2">Robert Kiyosaki</p>
                                <div class="mt-auto flex items-center justify-between pt-3">
                                    <span class="text-lg font-bold text-red-600">110.000đ</span>
                                    <button class="bg-blue-50 text-blue-600 hover:bg-blue-600 hover:text-white w-10 h-10 rounded-full flex items-center justify-center transition">
                                        <i class="fa-solid fa-cart-plus"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                    <!-- Phân trang -->
                    <div class="mt-10 flex justify-center gap-2">
                        <button class="px-3 py-1 border rounded text-gray-500 hover:bg-blue-50"><i class="fa-solid fa-chevron-left"></i></button>
                        <button class="px-3 py-1 border rounded bg-blue-600 text-white">1</button>
                        <button class="px-3 py-1 border rounded text-gray-600 hover:bg-blue-50">2</button>
                        <button class="px-3 py-1 border rounded text-gray-600 hover:bg-blue-50">3</button>
                        <button class="px-3 py-1 border rounded text-gray-500 hover:bg-blue-50"><i class="fa-solid fa-chevron-right"></i></button>
                    </div>
                </div>
            </div>
        </div>
</main>
    </body>
</html>
