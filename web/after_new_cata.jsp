<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/10/19
  Time: 2:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page errorPage="error.jsp" %>

<html>
<head>
    <title>After new cata</title>
</head>
<body>
    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <sql:update dataSource="${snapshot}">
        INSERT INTO Catagories
        VALUES (NULL, "<%=request.getParameter("new_cata_name")%>");
    </sql:update>

    <script>
        if(confirm("OK")){
            window.location.replace("admin_page.jsp");
        }
    </script>
</body>
</html>
