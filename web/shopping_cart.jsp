<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 12:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page errorPage="error.jsp" %>
<html>
<head>
    <title>My Shopping Cart</title>
</head>
<body>
    <%
        if(session.getAttribute("email") == null)
            throw new Exception("Session Timeout");
        String email = (String)session.getAttribute("email");
    %>

    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <sql:query var="get_user" dataSource="${snapshot}">
        SELECT * FROM Users WHERE Email = "<%=email%>";
    </sql:query>

    <c:forEach var="row" items="${get_user.rows}" end="0">
        <c:set var="user_name" value="${row.name}"/>
        <c:set var="user_id" value="${row.id}"/>
    </c:forEach>

    <h1 align="left"style="font-family: Helvetica; color: grey;">This is your shopping cart, ${user_name}</h1>

    <sql:query var="cart" dataSource="${snapshot}">
        SELECT * FROM ShoppingCarts WHERE user_id = ${user_id};
    </sql:query>

    <table width="100%" border="1">
        <tr>
            <th>Item ID</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total Price</th>
            <th> </th>
        </tr>
        <c:forEach var="row" items="${cart.rows}">
            <tr>
                <td>${row.good_id}</td>
                <td>${row.quantity}</td>
                <td>null</td>
                <td>null</td>
                <td>DELETE</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
