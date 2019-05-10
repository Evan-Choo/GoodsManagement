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

    <%--back home--%>
    <script>
        function home() {
            window.location.replace("user_page.jsp");
        }
    </script>
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

    <%--Hearder of shopping cart--%>
    <h1 align="left"style="font-family: Helvetica; color: grey;">This is your shopping cart, ${user_name}</h1>

    <sql:query var="cart" dataSource="${snapshot}">
        SELECT * FROM ShoppingCarts WHERE user_id = ${user_id};
    </sql:query>

    <%--Content of the cart--%>
    <table width="100%" border="1">
        <tr>
            <th>Item ID</th>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total Price</th>
            <th> </th>
        </tr>

        <c:set var="checkout_price" value="${0}"/>
        <c:forEach var="row" items="${cart.rows}">
            <tr>
                <td>${row.good_id}</td>
                <td>
                    <sql:query var="get_good" dataSource="${snapshot}">
                        SELECT * FROM Goods WHERE id = ${row.good_id};
                    </sql:query>

                    <c:forEach var="good" items="${get_good.rows}" end="0">
                        <c:set var="good_name" value="${good.name}"/>
                        <c:set var="good_price" value="${good.price}"/>
                    </c:forEach>

                    <c:out value="${good_name}"/>
                </td>
                <td>${row.quantity}</td>
                <td>${good_price}</td>
                <td>
                    <c:set var="sub_total" value="${row.quantity * good_price}"/>
                    <c:out value="${sub_total}"/>
                </td>
                <td>
                    <form method="post" name="delete_cart_item" action="delete_cart_item.do">
                        <button type="submit" name="id" value="${row.good_id}">DELETE</button>
                    </form>
                </td>

                <c:set var="checkout_price" value="${checkout_price + sub_total}"/>
            </tr>
        </c:forEach>
    </table>

    <div>
        <h2 align="left" style="font-family: Helvetica; color: grey">Your total bill is: ${checkout_price}</h2>
    </div>

    <div>
        <form method="post" action="checkout.do" name="checkout">
            <button type="submit" name="submit" id="checkout_btn">Check Out</button>
        </form>
        <button name="back_home" onclick="home()">Back</button>
    </div>


</body>
</html>
