<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
if(session.getAttribute("email")!=null)
       {  
   session.invalidate();
 
}
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Identity Verification</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
    </head>
    <body>
        <div id="main">		
            <header>
                <div id="strapline">
                    <div id="welcome_slogan">
                        <center><label style="font-size: 28px;color: white">Continuous User Identity Verification for <br />Secure Internet Services</label></center>
                    </div><!--close welcome_slogan-->
                </div><!--close strapline-->	  
                <nav style="margin-left: 200px;">
                    <div id="menubar">
                        <ul id="nav">
                            <li class="current"><a href="index.html">Home</a></li>
                            <li><a href="user.jsp">User</a></li>
                            <li><a href="server.jsp">Server</a></li>
                            <li><a href="reg.jsp">Registration</a></li>
                        </ul>
                    </div><!--close menubar-->	
                </nav>
            </header>
            <div id="site_content" style="height: 380px;"><br />		
                <div style="margin-top: 100px;color: white">
                    <img src="images/admin.png" width="300" height="200" style="float: right;transform: rotateY(30deg);margin-right: 100px;"/>
                    <center><h1>Server Login Page</h1></center><br />
                    <form style="margin-top: 10px;width: 500px;height:200px;margin-left: 150px;" action="loginaction.jsp" method="post"> 
                        <label style="font-size: 20px;">Username</label>&nbsp;&nbsp;<input type="text" class="textbox" placeholder="Enter Username" name="user" style="width: 200px;height: 18px;font-size: 15px;"/><br /><br />
                        <label style="font-size: 20px;">Password</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" class="textbox" placeholder="Enter Password" name="pass" style="width: 200px;height: 18px;font-size: 15px;" /><br /><br />
                        <input type="hidden" value="2" name="status" />
                        <input type="submit" value="Sign In" style="margin-left: 70px;width: 100px;height: 30px;border-radius: 4px;background: white;border-top-color: red;border-bottom-color: yellow"/>
                        &nbsp; &nbsp; <input type="reset"  style="width: 100px;height: 30px;border-radius: 4px;background: white;border-top-color: red;border-bottom-color: yellow"/><br /><br />
                    </form>   
                </div>
            </div><!--close site_content-->  	
       <footer>
                <br /><br />
            </footer>
        </div><!--close main-->
        <!-- javascript at the bottom for fast page loading -->
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/image_slide.js"></script>
    </body>
</html>

