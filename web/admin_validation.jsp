<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/7/19
  Time: 3:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>

<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.util.*, java.io.*, java.sql.*" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Admin Center</title>
</head>
<body>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <sql:query var="get_name" dataSource="${snapshot}">
        SELECT * FROM Admins WHERE email = "<%=session.getAttribute("email")%>";
    </sql:query>

    <c:set var="count" scope="request" value="${get_name.rowCount}"/>

    <c:forEach var="row" items="${get_name.rows}" end="0">
        <c:set var="correct_password" value="${row.password}" scope="request"/>
    </c:forEach>

    <%--Validate user email and password--%>
    <%
        String password = (String)session.getAttribute("password");
        session.removeAttribute("password");
        String correct_password = (String)request.getAttribute("correct_password");

        if((int)request.getAttribute("count") == 0)
            throw new Exception("Admin Does Not Exist!");
        if(!password.equals(correct_password))
            throw new Exception("Incorrect Password");
    %>

    <%--Set cookie email--%>
    <%
//        Cookie cookie = new Cookie("email", (String)session.getAttribute("email"));
//        session.removeAttribute("email");
//        cookie.setMaxAge(5*60);
//        response.addCookie(cookie);

        response.sendRedirect("admin_page.jsp");
    %>
</body>
</html>
