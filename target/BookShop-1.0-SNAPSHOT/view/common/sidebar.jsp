<%-- 
    Document   : sidebar
    Created on : Apr 13, 2026
    Author     : Admin
--%>

<aside class="w-64 bg-gray-100 p-6 sticky top-0 h-screen overflow-y-auto">
    <h3 class="text-lg font-bold text-gray-800 mb-4">Menu</h3>
    <ul class="space-y-2">
        <li><a href="<%=request.getContextPath()%>/view/customer/home.jsp" class="block px-4 py-2 hover:bg-blue-600 hover:text-white rounded">Trang chu</a></li>
        <li><a href="<%=request.getContextPath()%>/view/customer/index.jsp" class="block px-4 py-2 hover:bg-blue-600 hover:text-white rounded">Danh muc</a></li>
        <li><a href="<%=request.getContextPath()%>/view/customer/cart.jsp" class="block px-4 py-2 hover:bg-blue-600 hover:text-white rounded">Gio hang</a></li>
        <li><a href="<%=request.getContextPath()%>/view/customer/order-history.jsp" class="block px-4 py-2 hover:bg-blue-600 hover:text-white rounded">Don hang</a></li>
        <li><a href="<%=request.getContextPath()%>/view/customer/profile.jsp" class="block px-4 py-2 hover:bg-blue-600 hover:text-white rounded">Ho so</a></li>
    </ul>
</aside>