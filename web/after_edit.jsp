<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 11:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>After Edit</title>
</head>
<body>
    <%
        Integer original_catagory = (Integer)session.getAttribute("original_catagory");

        session.setAttribute("name", request.getParameter("name"));
        session.setAttribute("stock", request.getParameter("stock"));
        session.setAttribute("cur_catagory", request.getParameter("catagory"));
        String cur_catagory = request.getParameter("catagory");
        session.setAttribute("price", request.getParameter("price"));
        session.setAttribute("year", request.getParameter("year"));
        session.setAttribute("isbn", request.getParameter("isbn"));

        if(original_catagory != 0 && original_catagory != 1){
            switch (cur_catagory) {
                case "0":
                    session.setAttribute("situation", 1);
                    break;
                case "1":
                    session.setAttribute("situation", 2);
                    break;
                default:
                    session.setAttribute("situation", 0);
                    break;
            }
        } else if (original_catagory == 0) {
            switch (cur_catagory) {
                case "1":
                    session.setAttribute("situation", 3);
                    break;
                case "0":
                    session.setAttribute("situation", 4);
                    break;
                default:
                    session.setAttribute("situation", 5);
                    break;
            }
        } else {
            switch (cur_catagory) {
                case "0":
                    session.setAttribute("situation", 6);
                    break;
                case "1":
                    session.setAttribute("situation", 7);
                    break;
                default:
                    session.setAttribute("situation", 8);
                    break;
            }
        }
    %>

    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    UPDATE Goods
    SET name = "${sessionScope['name']}", stock = ${sessionScope['stock']}, catagory = ${sessionScope['cur_catagory']}, price = ${sessionScope['price']}
    WHERE id = ${sessionScope['good_id']};
    <sql:update dataSource="${snapshot}">
        UPDATE Goods
        SET name = "${sessionScope['name']}", stock = ${sessionScope['stock']}, catagory = ${sessionScope['cur_catagory']}, price = ${sessionScope['price']}
        WHERE id = ${sessionScope['good_id']};
    </sql:update>

    <c:choose>
        <c:when test="${sessionScope['situation'] == 0}">
            <%--doing nothing--%>
        </c:when>
        <c:when test="${sessionScope['situation'] == 1}">
            <sql:update dataSource="${snapshot}">
                INSERT INTO ${initParam['dbname0']}
                VALUES (${sessionScope['good_id']}, ${sessionScope['year']});
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['situation'] == 2}">
            <sql:update dataSource="${snapshot}">
                INSERT INTO ${initParam['dbname1']}
                VALUES (${sessionScope['good_id']}, "${sessionScope['isbn']}");
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['situation'] == 3}">
            <sql:update dataSource="${snapshot}">
                DELETE FROM ${initParam['dbname0']}
                WHERE ${initParam['idname0']} = ${sessionScope['good_id']}
            </sql:update>
            <sql:update dataSource="${snapshot}">
                INSERT INTO ${initParam['dbname1']}
                VALUES (${sessionScope['good_id']}, "${sessionScope['isbn']}");
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['situation'] == 4}">
            <sql:update dataSource="${snapshot}">
                UPDATE ${initParam['dbname0']}
                SET ${initParam['colname0']} = ${sessionScope['year']}
                WHERE ${initParam['idname0']} = ${sessionScope['good_id']};
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['situation'] == 5}">
            <sql:update dataSource="${snapshot}">
                DELETE FROM ${initParam['dbname0']}
                WHERE ${initParam['idname0']} = ${sessionScope['good_id']};
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['situation'] == 6}">
            <sql:update dataSource="${snapshot}">
                DELETE FROM ${initParam['dbname1']}
                WHERE ${initParam['idname1']} = ${sessionScope['good_id']}
            </sql:update>
            <sql:update dataSource="${snapshot}">
                INSERT INTO ${initParam['dbname0']}
                VALUES (${sessionScope['good_id']}, ${sessionScope['year']});
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['situation'] == 7}">
            <sql:update dataSource="${snapshot}">
                UPDATE ${initParam['dbname1']}
                SET ${initParam['colname1']} = "${sessionScope['isbn']}"
                WHERE ${initParam['idname1']} = ${sessionScope['good_id']};
            </sql:update>
        </c:when>
        <c:when test="${sessionScope['situation'] == 8}">
            <sql:update dataSource="${snapshot}">
                DELETE FROM ${initParam['dbname1']}
                WHERE ${initParam['idname1']} = ${sessionScope['good_id']};
            </sql:update>
        </c:when>
    </c:choose>

    <%--remove the session attributes--%>
    <%
        session.removeAttribute("year");
        session.removeAttribute("isbn");
    %>

    <script>
        if(confirm("OK")){
            window.location.replace("admin_page.jsp");
        }
    </script>
</body>
</html>
