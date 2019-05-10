<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/10/19
  Time: 5:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Select Cata</title>
</head>
<body>
    <%
        session.setAttribute("cur_cata", request.getParameter("cur_cata"));
        response.sendRedirect("user_page.jsp");
    %>
</body>
</html>
