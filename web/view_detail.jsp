<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 10:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page errorPage="error.jsp" %>

<html>
<head>
    <title>Good Detail</title>

    <%--back home function--%>
    <script>
        function home(){
            window.location.replace("user_page.jsp");
        }
    </script>
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
    <c:set var="good_id" value="${paramValues.id[0]}"/>

    <%--Get the type of the good--%>
    <sql:query var="get_good" dataSource="${snapshot}">
        SELECT * FROM Goods WHERE id = ${good_id};
    </sql:query>

    <c:forEach var="row" items="${get_good.rows}" end="0">
        <c:set var="good_name" value="${row.name}"/>
        <c:set var="good_stock" value="${row.stock}"/>
        <c:set var="good_catagory_int" value="${row.catagory}"/>
        <c:set var="good_price" value="${row.price}"/>
    </c:forEach>

    <sql:query var="get_cata_name" dataSource="${snapshot}">
        SELECT * FROM Catagories WHERE id = ${good_catagory_int};
    </sql:query>

    <c:forEach var="row" items="${get_cata_name.rows}" end="0">
        <c:set var="good_catagory_name" value="${row.name}"/>
    </c:forEach>

    <%--Print out common info--%>
    <h2 align="left" style="font-family: Helvetica; color: grey;">ID: ${good_id}</h2>
    <h2 align="left" style="font-family: Helvetica; color: grey;">Name: ${good_name}</h2>
    <h2 align="left" style="font-family: Helvetica; color: grey;">
        Stock:
        <c:choose>
            <c:when test="${good_stock == 0}">
                <c:out value="out of stock"/>
            </c:when>
            <c:otherwise>
                <c:out value="${good_stock}"/>
            </c:otherwise>
        </c:choose>
    </h2>
    <h2 align="left" style="font-family: Helvetica; color: grey;">Catagory: ${good_catagory_name}</h2>
    <h2 align="left" style="font-family: Helvetica; color: grey;">Price: ${good_price}</h2>

    <c:choose>
        <%--electronic device--%>
        <c:when test="${good_catagory_int == 0}">
            <sql:query var="electro_year" dataSource="${snapshot}">
                SELECT * FROM ${initParam['dbname0']} WHERE ${initParam['idname0']} = ${good_id};
            </sql:query>
            <c:forEach var="row" items="${electro_year.rows}" end="0">
                <c:set var="content" value="${row[initParam['colname0']]}"/>
            </c:forEach>
            <h2 align="left" style="font-family: Helvetica; color: blue;">
                <c:out value="${initParam['title0']}"/>
                <c:out value="${content}"/>
            </h2>
        </c:when>

        <%--book--%>
        <c:when test="${good_catagory_int == 1}">
            <sql:query var="book_isbn" dataSource="${snapshot}">
                SELECT * FROM ${initParam['dbname1']} WHERE ${initParam['idname1']} = ${good_id};
            </sql:query>
            <c:forEach var="row" items="${book_isbn.rows}" end="0">
                <c:set var="content" value="${row[initParam['colname1']]}"/>
            </c:forEach>
            <h2 align="left" style="font-family: Helvetica; color: red;">
                <c:out value="${initParam['title1']}"/>
                <c:out value="${content}"/>
            </h2>
        </c:when>
    </c:choose>

    <button name="back_home" onclick="home()">Back</button>

</body>
</html>
