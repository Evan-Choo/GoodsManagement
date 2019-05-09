<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 10:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page errorPage="error.jsp" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Add to Cart</title>
</head>
<body>
    <%--Check the vadility of the session--%>
    <%
        if(session.getAttribute("email") == null)
            throw new Exception("Session Timeout");
        String email = (String)session.getAttribute("email");
    %>

    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <%--Get user id--%>
    <sql:query var="get_userid" dataSource="${snapshot}">
        SELECT * FROM Users WHERE email = "<%=email%>";
    </sql:query>

    <c:forEach var="row" items="${get_userid.rows}" end="0">
        <c:set var="user_id" value="${row.id}"/>
    </c:forEach>

    <%--Get good id from post parameter--%>
    <%--Check good inventory; if there is non left, throw an exception--%>
    <c:choose>
        <c:when test="${sessionScope.good_id == null}">
            <c:out value="${5/0}"/>
        </c:when>
        <c:otherwise>
            <c:set var="good_id" value="${sessionScope.good_id}"/>
            <%session.removeAttribute("good_id");%>
        </c:otherwise>
    </c:choose>

    <sql:query var="get_good" dataSource="${snapshot}">
        SELECT * FROM Goods WHERE id = ${good_id};
    </sql:query>

    <c:forEach var="row" items="${get_good.rows}" end="0">
        <c:set var="good_name" value="${row.name}" scope="request"/>
        <c:set var="inventory" value="${row.stock}" scope="request"/>
    </c:forEach>

    <%--If non is left--%>
    <%
        Integer inventory = (Integer)request.getAttribute("inventory");
        String good_name = (String)request.getAttribute("good_name");

        if(inventory == null)
            throw new Exception("Null Inventory");
        if(inventory == 0)
            throw new Exception(good_name+" has run out of stock!");
    %>

    <%--else add one to the user's cart, first check if it exists--%>
    <sql:query var="get_cartitem" dataSource="${snapshot}">
        SELECT * FROM ShoppingCarts WHERE user_id = ${user_id} and good_id = ${good_id};
    </sql:query>

    <c:set var="item_count" value="${get_cartitem.rowCount}" scope="request"/>

    <c:choose>
        <%--When there is no such item--%>
        <c:when test="${item_count == 0}">
            <sql:update dataSource="${snapshot}">
                INSERT INTO ShoppingCarts VALUES (${user_id}, ${good_id}, 1);
            </sql:update>
        </c:when>
        <%--When such item exists--%>
        <c:otherwise>
            <%--First get the quantity of it in the cart--%>
            <c:forEach var="cart_item" items="${get_cartitem.rows}" end="0">
                <c:set var="cart_quantity" value="${cart_item.quantity}"/>
            </c:forEach>
            <%--Then update the item quantity--%>
            <sql:update dataSource="${snapshot}">
                UPDATE ShoppingCarts
                SET quantity = ${cart_quantity + 1}
                WHERE user_id = ${user_id} AND good_id = ${good_id};
            </sql:update>
        </c:otherwise>
    </c:choose>
    <%--Accordingly, the stock should decrease--%>
    <sql:update dataSource="${snapshot}">
        UPDATE Goods
        SET stock = ${inventory - 1}
        WHERE id = ${good_id};
    </sql:update>

    <%--And then notifier the customer--%>
    <script>
        if(confirm("OK")){
            window.location.replace("user_page.jsp");
        }
    </script>

</body>
</html>
