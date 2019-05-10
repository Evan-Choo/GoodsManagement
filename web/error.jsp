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
    <script>
        function home() {
            window.location.replace("index.jsp");
        }
    </script>
</head>
<body>
    <br><br>
    <h1 align="center" style="font-family: Helvetica; color: red" id="message"><%=exception.getMessage()%></h1>

    <button name="back_home" onclick="home()">Back</button>
</body>
</html>
