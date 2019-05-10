<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 7:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Delete Good</title>
</head>
<body>
    <%
        if(session.getAttribute("email") == null)
            throw new Exception("Session Timeout");
        String email = (String)session.getAttribute("email");
    %>

    <%
        session.setAttribute("good_id", request.getParameter("delete"));
    %>

    <sql:setDataSource var="snapshot" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <sql:query var="get_good" dataSource="${snapshot}">
        SELECT * FROM Goods WHERE id = <%=session.getAttribute("good_id")%>;
    </sql:query>

    <c:forEach var="good" items="${get_good.rows}" end="0">
        <c:set var="good_catagory" value="${good.catagory}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${good_catagory == 0}">
            <%--delete specific info--%>
            <sql:update dataSource="${snapshot}">
                DELETE FROM ${initParam['dbname0']}
                WHERE ${initParam['idname0']} = ${sessionScope['good_id']};
            </sql:update>
        </c:when>
        <c:when test="${good_catagory == 1}">
            <%--delete specific info--%>
            <sql:update dataSource="${snapshot}">
                DELETE FROM ${initParam['dbname1']}
                WHERE ${initParam['idname1']} = ${sessionScope['good_id']};
            </sql:update>
        </c:when>
        <c:otherwise>
            <%--doing nothing--%>
        </c:otherwise>
    </c:choose>

    <%--delete from shopping cart--%>
    <sql:update dataSource="${snapshot}">
        DELETE FROM ShoppingCarts
        WHERE good_id = ${sessionScope['good_id']};
    </sql:update>

    <%--delete from catagory--%>
    <sql:update dataSource="${snapshot}">
        DELETE FROM Catagories
        WHERE id = ${sessionScope['good_id']};
    </sql:update>

    <%--finally, delete from goods itself--%>
    <sql:update dataSource="${snapshot}">
        DELETE FROM Goods
        WHERE id = ${sessionScope['good_id']};
    </sql:update>

    <%session.removeAttribute("good_id");%>

    <%--confirm--%>
    <script>
        if(confirm("OK")) {
            window.location.replace("admin_page.jsp");
        }
    </script>
</body>
</html>
