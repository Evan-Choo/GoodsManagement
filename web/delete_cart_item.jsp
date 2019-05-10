<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 4:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page errorPage="error.jsp" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Delete Cart Item</title>
</head>
<body>
    <%--Validate the effectiveness of session--%>
    <%
        if(session.getAttribute("email") == null)
            throw new Exception("Session Timeout");
        String email = (String)session.getAttribute("email");
    %>

    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <%--get user id--%>
    <sql:query var="get_user" dataSource="${snapshot}">
        SELECT * FROM Users WHERE Email = "<%=email%>";
    </sql:query>

    <c:forEach var="row" items="${get_user.rows}" end="0">
        <c:set var="user_id" value="${row.id}" scope="request"/>
    </c:forEach>

    <%--Get good id from post parameter--%>
    <%
        String id = request.getParameter("id");
        session.setAttribute("good_id", id);
    %>

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

    <%--If the good is longer exists, throw exception--%>
    <%
        Integer inventory = (Integer)request.getAttribute("inventory");
        String good_name = (String)request.getAttribute("good_name");

        if(inventory == null)
            throw new Exception(good_name+ "no longer exists!");
    %>

    <%--get the quantity of the cart item--%>
    SELECT * FROM ShoppingCarts WHERE user_id = ${user_id} AND good_id = ${good_id};
    <sql:query var="get_cartitem" dataSource="${snapshot}">
        SELECT * FROM ShoppingCarts WHERE user_id = ${user_id} AND good_id = ${good_id};
    </sql:query>

    <c:forEach var="cart_item" items="${get_cartitem.rows}" end="0">
        <c:set var="item_quantity" value="${cart_item.quantity}" scope="request"/>
    </c:forEach>

    <%--remove cart item from ShoppingCarts--%>
    <sql:update dataSource="${snapshot}">
        DELETE FROM ShoppingCarts WHERE user_id = ${user_id} AND good_id = ${good_id};
    </sql:update>

    <%--add the cart item to Goods; restore the stock--%>
    <sql:update dataSource="${snapshot}">
        UPDATE Goods
        SET stock = ${inventory + item_quantity}
        WHERE id = ${good_id};
    </sql:update>

    <%--And then notifier the customer--%>
    <script>
        if(confirm("OK")){
            window.location.replace("shopping_cart.jsp");
        }
    </script>
</body>
</html>
