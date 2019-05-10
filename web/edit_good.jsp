<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 7:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page errorPage="error.jsp" %>

<html>
<head>
    <title>Edit Good</title>
    <script>
        function home() {
            window.location.replace("admin_page.jsp");
        }

        function toggle() {
            if(document.getElementById('catagory').value === "0"){
                document.getElementById('year_div').style.display = 'block';
                document.getElementById('isbn_div').style.display = 'none';
            } else if (document.getElementById('catagory').value === "1") {
                document.getElementById('year_div').style.display = 'none';
                document.getElementById('isbn_div').style.display = 'block';
            } else {
                document.getElementById('year_div').style.display = 'none';
                document.getElementById('isbn_div').style.display = 'none';
            }
        }

        function validate() {
            if(document.getElementById('catagory').value == "0" && document.getElementById('year').value == ""){
                alert("Must fill year!");
                return false;
            } else if (document.getElementById('catagory').value == "1" && document.getElementById('isbn').value == "") {
                alert("Must fill isbn");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <%
        if(session.getAttribute("email") == null)
            throw new Exception("Session Timeout");
        String email = (String)session.getAttribute("email");
    %>

    <%--get the id of the good to be edited--%>
    <%
        String id = request.getParameter("edit");
        session.setAttribute("good_id", id);
    %>

    <sql:setDataSource var="snapshot" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <%--get the according good--%>
    <sql:query var="get_good" dataSource="${snapshot}">
        SELECT * FROM Goods WHERE id = ${sessionScope['good_id']};
    </sql:query>

    <c:forEach var="row" items="${get_good.rows}" end="0">
        <form method="post" name="edit_good_form" action="after_edit.do">
        <div>
            <label for="id">ID:</label>
            <input type="text" value="${row.id}" id="id" readonly>
        </div>

        <div>
            <label for="name">Name:</label>
            <input type="text" value="${row.name}" id="name" name="name">
        </div>

        <div>
            <label for="stock">Stock:</label>
            <input type="text" value="${row.stock}" id="stock" name="stock">
        </div>

        <div>
            <label for="catagory">Catagory:</label>
            <select id="catagory" onchange="toggle()" name="catagory">
                <sql:query var="get_catagory" dataSource="${snapshot}">
                    SELECT * FROM Catagories;
                </sql:query>
                <c:forEach var="cata" items="${get_catagory.rows}">
                    <c:choose>
                        <c:when test="${row.catagory == cata.id}">
                            <option value="${cata.id}" selected>${cata.id}.${cata.name}</option>
                            <c:set var="original_catagory" value="${cata.id}" scope="session"/>
                        </c:when>
                        <c:otherwise>
                            <option value="${cata.id}">${cata.id}.${cata.name}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>

        <div>
            <label for="price">Price:</label>
            <input type="text" value="${row.price}" id="price" name="price">
        </div>

        <c:choose>
            <%--when the item is eletronic device--%>
            <c:when test="${row.catagory == 0}">
                <sql:query var="get_year" dataSource="${snapshot}">
                    SELECT * FROM ${initParam['dbname0']} WHERE ${initParam['idname0']} = ${row.id};
                </sql:query>

                <c:forEach var="electro" items="${get_year.rows}">
                    <c:set var="debut_year" value="${electro.year}"/>
                </c:forEach>

                <c:set var="year_display" value="block"/>
                <c:set var="isbn_display" value="none"/>
            </c:when>

            <%--when the item is book--%>
            <c:when test="${row.catagory == 1}">
                <sql:query var="get_isbn" dataSource="${snapshot}">
                    SELECT * FROM ${initParam['dbname1']} WHERE ${initParam['idname1']} = ${row.id}
                </sql:query>

                <c:forEach var="book" items="${get_isbn.rows}">
                    <c:set var="book_isbn" value="${book.isbn}"/>
                </c:forEach>

                <c:set var="year_display" value="none"/>
                <c:set var="isbn_display" value="block"/>
            </c:when>

            <c:otherwise>
                <c:set var="year_display" value="none"/>
                <c:set var="isbn_display" value="none"/>
            </c:otherwise>
        </c:choose>

        <div id="year_div" style="display: ${year_display}">
            <label for="year" style="color: red;">${initParam['title0']}</label>
            <input type="text" value="${debut_year}" id="year" name="year">
        </div>

        <div id="isbn_div" style="display: ${isbn_display};" name="isbn">
            <label for="isbn" style="color: blue;">${initParam['title1']}</label>
            <input type="text" value="${book_isbn}" id="isbn" name="isbn">
        </div>

        <button type="submit" onclick="return validate()">OK</button>
        </form>
    </c:forEach>

    <button onclick="home()">Back</button>
</body>
</html>
