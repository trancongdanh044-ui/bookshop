<%-- 
    Document   : index
    Created on : Apr 8, 2026, 7:42:58 AM
    Author     : lenovo
--%>

<%@ include file="../common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<h2>Danh sách sách</h2>

<c:forEach var="b" items="${books}">
    <div>
        <h3>${b.title}</h3>
        <p>Giá: ${b.price}</p>
        <a href="book-detail.jsp?id=${b.id}">Xem</a>
    </div>
</c:forEach>

<%@ include file="../common/footer.jsp" %>
    </body>
</html>
