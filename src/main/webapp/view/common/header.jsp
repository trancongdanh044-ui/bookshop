<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    Object cartCount = session.getAttribute("cartCount");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%=request.getContextPath()%>/BookController">BookShop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">
            <%-->
                <form class="d-flex ms-lg-4 my-3 my-lg-0 flex-grow-1" action="<%=request.getContextPath()%>/BookController" method="get">
                <input class="form-control me-2" type="search" name="search" placeholder="Tìm sách theo tên, tác giả">
                <button class="btn btn-light" type="submit">Tìm</button>
            </form>
            <--%>

            <ul class="navbar-nav ms-lg-3 align-items-lg-center">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/BookController">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/CartController">
                        Giỏ hàng (<%= cartCount == null ? 0 : cartCount %>)
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/OrderController?action=history">Lịch sử mua hàng</a>
                </li>
                <% if (user != null && "admin".equals(user.getRole())) { %>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/AdminController?action=dashboard">Admin</a>
                </li>
                <% } %>
                <% if (user != null) { %>
                <li class="nav-item">
                    <span class="navbar-text ms-lg-2"><%= user.getFullName() != null ? user.getFullName() : user.getUsername() %></span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/AuthController?action=logout">Đăng xuất</a>
                </li>
                <% } else { %>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/AuthController?action=login">Đăng nhập</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/AuthController?action=register">Đăng ký</a>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
