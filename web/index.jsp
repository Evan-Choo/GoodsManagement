<!--import statements-->

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>

    <!--validate the well-formedness of the input data-->
    <script>
        function validateForm() {
            var email = document.forms["loginForm"]["email"].value;
            var password = document.forms["loginForm"]["password"].value;

            //validation of email address
            if(email == null || email == ""){
                alert("Please Input Email");
                return false;
            }
            var atpos=email.indexOf("@");
            var dotpos=email.lastIndexOf(".");
            if (atpos<1 || dotpos<atpos+2 || dotpos+2>=email.length){
                alert("Invalid Email Address");
                return false;
            }

            //validation of password
            if(password == null || password == "") {
                alert("Please Input Password");
                return false;
            }

            return true;
        }
    </script>
</head>

<body>
    <h1 align="center" style="font-family: Helvetica;">Goods Home</h1>

    <br><br>

    <form name="loginForm" method="post" action="Login.do" onsubmit="return validateForm()">
        <div align="center">
            <label for="email">Email:</label>
            <input type="text" name="email" id="email" />
        </div>

        <div align="center">
            <label for="password">Password:</label>
            <input type="password" name="password" id="password">
        </div>

        <br><br>

        <div align="center">
            <button type="submit" name="submit" value="admin">Admin Login</button>
            <button type="submit" name="submit" value="user">User Login</button>
        </div>
    </form>

    <br><br>

    <div align="center">
        <a href="sign_up.html">Sign Up as User</a>
    </div>
</body>
</html>