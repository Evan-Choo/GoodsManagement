<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 7:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page errorPage="error.jsp" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Add New Good</title>
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
            if(document.getElementById('catagory').value === "0" && document.getElementById("year").value == ""){
                alert("Must fill year");
                return false;
            } else if (document.getElementById('catagory').value === "1" && document.getElementById("isbn").value == "") {
                alert("Must fill ISBN");
                return false;
            }
        }
    </script>
</head>
<body>

    <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/GoodsManage" user="root" password=""/>

    <form method="post" name="new_good" action="after_add_good.do">
        <div>
            <label for="name">Name: </label>
            <input type="text" name="name" id="name">
        </div>

        <div>
            <label for="stock">Stock: </label>
            <input type="text" name="stock" id="stock">
        </div>

        <div>
            <label for="catagory">Catagory: </label>
            <select id="catagory" name="catagory" onchange="toggle()">
                <sql:query var="cata" dataSource="${snapshot}">
                    SELECT * FROM Catagories;
                </sql:query>
                <c:forEach var="row" items="${cata.rows}">
                    <option value="${row.id}">${row.id}.${row.name}</option>
                </c:forEach>
            </select>
        </div>

        <div>
            <label for="price">Price: </label>
            <input type="text" name="price" id="price">
        </div>

        <div style="display: block;" id="year_div">
            <label for="year" style="color: red;">Year: </label>
            <input type="text" name="year" id="year">
        </div>

        <div style="display: none;" id="isbn_div">
            <label for="isbn" style="color: blue;">ISBN: </label>
            <input type="text" name="isbn" id="isbn">
        </div>

        <button type="submit" onclick="return validate">OK</button>
        <button onclick="home()">Back</button>
    </form>
</body>
</html>
