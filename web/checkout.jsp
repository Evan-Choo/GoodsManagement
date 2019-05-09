<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 7:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page errorPage="error.jsp" %>

<html>
<head>
    <title>Checkout</title>

    <%--back home func--%>
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

    <sql:query var="get_id" dataSource="${snapshot}">
        SELECT * FROM Users WHERE Email = "<%=email%>";
    </sql:query>

    <c:forEach var="row" items="${get_id.rows}" end="0">
        <c:set var="user_id" value="${row.id}"/>
        <c:set  var="user_name" value="${row.name}"/>
    </c:forEach>

    <sql:update dataSource="${snapshot}">
        DELETE FROM ShoppingCarts WHERE user_id = ${user_id};
    </sql:update>

    <h1 style="font-family: Helvetica; color: darkslategrey;" align="center">Succeed, ${user_name}! Thank you!</h1>
    <div>
        <button name="back_home">Back</button>
    </div>
</body>
</html>
