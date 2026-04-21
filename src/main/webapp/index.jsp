<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>

<%
    // Always redirect to BookController to show product list (no login required for browsing)
    response.sendRedirect("BookController");
%>