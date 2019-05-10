<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/8/19
  Time: 11:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page errorPage="error.jsp" %>

<html>
<head>
    <title>Admin Center</title>
</head>
<body>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <%--Get the email of the Admin from cookies for further use--%>
    <%
//        Cookie[] cookies = request.getCookies();
//        String admin_email = "";
//        if(cookies != null) {
//            for(int i = 0; i < cookies.length; i++) {
//                Cookie cookie = cookies[i];
//                if(cookie.getName().equals("email")){
//                    admin_email = cookie.getValue();
//                    break;
//                }
//            }
//        }
        if(session.getAttribute("email") == null)
            throw new Exception("Session Timeout");
        String email = (String)session.getAttribute("email");
    %>

    <div>
        <h1 align="left" style="font-family: Helvetica; color: grey;">Hello, Admin(<%=email%>)</h1>
    </div>

    <div>
        <a href="log_out.jsp">Log Out</a>
    </div>

    <div>
        <a href="add_catagory.jsp">Add Catagory</a>
    </div>

    <div>
        <a href="add_new_good.jsp">Add New Good</a>
    </div>

    <sql:query var="all_goods" dataSource="${snapshot}">
        SELECT * FROM Goods;
    </sql:query>

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
                <td>
                    <form name="edit_good" method="post" action="edit_good.do">
                        <button type="submit" name="edit" value="${row.id}">Edit Info</button>
                    </form>
                </td>
                <td>
                    <form name="delete_good" method="post" action="delete_good.do">
                        <button type="submit" name="delete" value="${row.id}">DELETE</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
