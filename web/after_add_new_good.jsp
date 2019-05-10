<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/10/19
  Time: 3:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>After add new good</title>
</head>
<body>

    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <%
        session.setAttribute("name", request.getParameter("name"));
        session.setAttribute("stock", request.getParameter("stock"));
        session.setAttribute("catagory", request.getParameter("catagory"));
        session.setAttribute("price", request.getParameter("price"));
        session.setAttribute("year", request.getParameter("year"));
        session.setAttribute("isbn", request.getParameter("isbn"));
    %>

    <sql:update dataSource="${snapshot}">
        INSERT INTO Goods
        VALUES (NULL, "${sessionScope['name']}", ${sessionScope['stock']}, ${sessionScope['catagory']}, ${sessionScope['price']});
    </sql:update>

    <sql:query var="lastid" dataSource="${snapshot}">
        SELECT * FROM Goods WHERE name = "${sessionScope['name']}" and stock = ${sessionScope['stock']} and catagory = ${sessionScope['catagory']} and price = ${sessionScope['price']};
    </sql:query>

    <c:forEach var="lid" items="${lastid.rows}" end="0">
        <c:set var="cur_id" value="${lid.id}"/>
    </c:forEach>

    <c:choose>
        <c:when test="${sessionScope['catagory'] == 0}">
            <sql:update dataSource="${snapshot}">
                INSERT INTO ${initParam['dbname0']}
                VALUES (${cur_id}, ${sessionScope['year']});
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['catagory'] == 1}">
            <sql:update dataSource="${snapshot}">
                INSERT INTO ${initParam['dbname1']}
                VALUES (${cur_id}, "${sessionScope['isbn']}");
            </sql:update>
        </c:when>
    </c:choose>

    <script>
        if(confirm("OK")){
            window.location.replace("admin_page.jsp");
        }
    </script>
</body>
</html>
