<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/7/19
  Time: 9:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>

<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Sign Up</title>
</head>
<body>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <sql:query var="get_name" dataSource="${snapshot}">
        SELECT * FROM Users WHERE Email = "<%=session.getAttribute("email")%>";
    </sql:query>


    <c:set var="res_count" value="${get_name.rowCount}" scope="request"/>

    <%
        int rowCount = (int)request.getAttribute("res_count");
        if(rowCount != 0)
            throw new Exception("Email Already Taken!");
    %>

    <sql:update dataSource="${snapshot}">
        INSERT INTO Users VALUES (NULL, '<%=session.getAttribute("name")%>', '<%=session.getAttribute("email")%>', '<%=session.getAttribute("password")%>');
    </sql:update>

    <%
        session.removeAttribute("name");
        session.removeAttribute("password");
    %>

    <%
        session.setAttribute("cur_cata", -1);
        response.sendRedirect("user_page.jsp");
    %>
</body>
</html>
