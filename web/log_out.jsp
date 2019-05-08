<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 12:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Goods Home</title>
</head>
<body>
    <%
        session.invalidate();
//        Cookie[] cookies = request.getCookies();
//        for(Cookie cookie : cookies) {
//            if(cookie.getName().equals("email"))
//                cookie.setValue("");
//        }
        response.sendRedirect("index.jsp");
    %>
</body>
</html>
