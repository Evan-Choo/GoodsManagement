<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/7/19
  Time: 2:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>

<html>
<head>
    <title>Error!</title>
</head>
<body>
    <br><br>
    <h1 align="center" style="font-family: Helvetica; color: red"><%=exception.getMessage()%></h1>
</body>
</html>
