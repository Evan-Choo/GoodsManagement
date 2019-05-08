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

    <%session.removeAttribute("email");%>

    <c:set var="count" scope="request" value="${get_name.rowCount}"/>

    <c:forEach var="row" items="${get_name.rows}" end="0">
        <c:set var="correct_password" value="${row.password}" scope="request"/>
    </c:forEach>

    <%
        String password = (String)session.getAttribute("password");
        session.removeAttribute("password");
        String correct_password = (String)request.getAttribute("correct_password");

        if((int)request.getAttribute("count") == 0)
            throw new Exception("Admin Does Not Exist!");
        if(!password.equals(correct_password))
            throw new Exception("Incorrect Password");
    %>

    <sql:query var="all_goods" dataSource="${snapshot}">
        SELECT * FROM Goods;
    </sql:query>

    <div>
        <h1 align="left" style="font-family: Helvetica; color: grey;">Hello, Admin</h1>
    </div>

    <div>
        <button name="addCatagory">Add Catagory</button>
        <button name="addGood">Add Goods</button>
    </div>

    <table width="100%" border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Stock</th>
            <th>Catagory</th>
            <th>Price</th>
            <th> </th>
            <th> </th>
        </tr>

        <c:forEach var="row" items="${all_goods.rows}">
            <tr>
                <td><c:out value="${row.id}"/></td>
                <td><c:out value="${row.name}"/></td>
                <td><c:out value="${row.stock}"/></td>
                <td><c:out value="${row.catagory}"/></td>
                <td><c:out value="${row.price}"/></td>
                <td><a href="sign_up.html">Edit</a></td>
                <td><a href="delete">DELETE</a> </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
