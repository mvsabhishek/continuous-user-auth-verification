<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
if(session.getAttribute("name")!="server")
       {  
 response.sendRedirect("server.jsp");
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
                <nav style="">
                    <div id="menubar">
                        <ul id="nav">
                            <li class="current"><a href="shome.jsp">Home</a></li>
                            <li><a href="userdetails.jsp">Customer Details</a></li>
                            <li><a href="beneficialdetails.jsp">Beneficial</a></li>
                            <li><a href="transaction.jsp">Transaction</a></li>
                            <li><a href="blocked.jsp">Blocked Account</a></li>
                            <li><a href="servlogout.jsp">Log Out</a></li>
                        </ul>
                    </div><!--close menubar-->	
                </nav>
            </header>
            <div id="site_content" style="height: 380px;"><br />		
                <div style="color: white;height: 400px;background: url('images/bank15.jpg')">
                      
                </div>
            </div><!--close site_content-->  	
 <footer>
                <br /><br />
            </footer>        </div><!--close main-->
        <!-- javascript at the bottom for fast page loading -->
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/image_slide.js"></script>
    </body>
</html>

