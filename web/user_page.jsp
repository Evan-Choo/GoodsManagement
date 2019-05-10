<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/8/19
  Time: 11:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page errorPage="error.jsp" %>

<html>
<head>
    <title>User Center</title>
</head>
<body>
    <%
        if(session.getAttribute("email") == null)
            throw new Exception("Session Timeout");
        String email = (String)session.getAttribute("email");
    %>

    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <sql:query var="get_name" dataSource="${snapshot}">
        SELECT * FROM Users WHERE Email = "<%=email%>";
    </sql:query>

    <c:forEach var="row" items="${get_name.rows}" end="0">
        <c:set var="user_name" value="${row.name}" scope="request"/>
    </c:forEach>

    <div>
        <h1 align="left" style="font-family: Helvetica; color: grey">Hello, ${user_name}</h1>
    </div>

    <div>
        <a href="log_out.jsp">Log Out</a>
    </div>

    <div>
        <a href="shopping_cart.jsp">My Shopping Cart</a>
    </div>

    <c:choose>
        <c:when test="${sessionScope['cur_cata'] == -1}">
            <sql:query var="show_goods" dataSource="${snapshot}">
                SELECT * FROM Goods;
            </sql:query>
        </c:when>
        <c:otherwise>
            <sql:query var="show_goods" dataSource="${snapshot}">
                SELECT * FROM Goods WHERE catagory = ${sessionScope['cur_cata']};
            </sql:query>
        </c:otherwise>
    </c:choose>

    <sql:query var="all_cata" dataSource="${snapshot}">
        SELECT * FROM Catagories;
    </sql:query>

    <div>
        <form method="post" action="select_cata.do">
            <select name="cur_cata" id="cur_cata">
                <option value="-1" selected>ALL</option>
                <c:forEach var="row" items="${all_cata.rows}">
                    <c:choose>
                        <c:when test="${row.id == sessionScope['cur_cata']}">
                            <option value="${row.id}" selected>${row.id}.${row.name}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${row.id}">${row.id}.${row.name}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
            <button type="submit">OK</button>
        </form>
    </div>

    <table width="100%" border="1">
        <tr>
            <td>ID</td>
            <th>Name</th>
            <th>Price</th>
            <th>Stock</th>
            <th> </th>
            <th> </th>
        </tr>
        <c:forEach var="row" items="${show_goods.rows}">
            <tr>
                <td>${row.id}</td>
                <td>${row.name}</td>
                <td>${row.price}</td>
                <td>${row.stock}</td>
                <td>
                    <form method="post" name="add_good" action="add_good.do">
                        <button type="submit" name="id" value="${row.id}">Add to Cart</button>
                    </form>
                </td>
                <td>
                    <form method="post" name="view_detail" action="view_detail.do">
                        <button type="submit" name="id" value="${row.id}">View Detail</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>
