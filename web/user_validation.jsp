<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/7/19
  Time: 1:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>

<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.*, java.util.*, java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>User Center</title>
</head>
<body>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <sql:query var="get_name" dataSource="${snapshot}">
        SELECT * FROM Users WHERE Email = "<%=(String)session.getAttribute("email")%>";
    </sql:query>

    <c:set var="rowNumber" value="${get_name.rowCount}" scope="request"/>

    <c:forEach var="row" items="${get_name.rows}" end="0">
        <c:set var="correct_password" value="${row.password}" scope="request"/>
        <c:set var="user_name" value="${row.name}" scope="request"/>
    </c:forEach>

    <%
        int rowCount = (int)request.getAttribute("rowNumber");
        String correct_password = (String)request.getAttribute("correct_password");
        String password = (String)session.getAttribute("password");

        session.removeAttribute("password");

        if(rowCount == 0)
            throw new Exception("Email Address Does Not Exist!");
        if(rowCount != 1)
            throw new Exception("Internal Database Error: Duplicated Emails");
        if(!password.equals(correct_password))
            throw new Exception("Incorrect Password!");
    %>

    <%
        Cookie cookie = new Cookie("email", (String)session.getAttribute("email"));
        cookie.setMaxAge(20);
        response.addCookie(cookie);

        response.sendRedirect("user_page.jsp");
    %>

</body>
</html>
