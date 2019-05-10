<%--
  Created by IntelliJ IDEA.
  User: evanchoo
  Date: 5/9/19
  Time: 7:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Add Catagory</title>

    <script>
        function validate() {
            var content = document.getElementById("cata_name").value;
            if(content == "" || content == null){
                alert("Must fill name!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form method="post" action="after_add_catagory.do" name="new_cata">
        <div>
            <label for="cata_name">Catagory Name: </label>
            <input type="text" name="new_cata_name" id="cata_name">
        </div>
        <button type="submit" id="ok" onclick="return validate()">OK</button>
    </form>
</body>
</html>
