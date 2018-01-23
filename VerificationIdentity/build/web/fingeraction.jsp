<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
if(session.getAttribute("email")==null)
       {  
 response.sendRedirect("user.jsp");
}
else{
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    String fin = null;
    String email = session.getAttribute("email").toString();
                    try {
                        con = Database.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery("select finlog from reg where email='" + email + "'");
                        while(rs.next()){
                        fin = rs.getString("finlog");
                        }
                        if( fin.equals("0"))
                        {
                            response.sendRedirect("user.jsp");  
                        }
                    } catch (Exception ex) {  
                        ex.printStackTrace();
                    }
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
        <style>
            .myButton{
                width: 100px;
                height: 25px;
                border-radius: 4px;
                background: white;
                border-bottom-color: yellow;
                border-top-color: red;
            }
        </style>
    </head>
    <body>
        <%
            if(request.getParameter("msgg")!=null)
            {%>
            <script>alert('Please give Correct Input');</script>  
            <%}
        %>
        <div id="main">		
            <header>
                <div id="strapline">
                    <div id="welcome_slogan">
                        <center><label style="font-size: 28px;color: white">Continuous User Identity Verification for <br />Secure Internet Services</label></center>
                    </div><!--close welcome_slogan-->
                </div><!--close strapline-->	  
                <nav>
                    <div id="menubar">
                        <ul id="nav" style="margin-left: 200px">
                            <li class="current"><a href="index.html">Home</a></li>
                            <li><a href="user.jsp">User</a></li>
                            <li><a href="server.jsp">Server</a></li>
                            <li><a href="reg.jsp">Registration</a></li>
                        </ul>
                    </div><!--close menubar-->	
                </nav>
            </header>
            <div id="site_content" style="height: 380px;"><br /><br /><br />
                <%
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;
                    String name = null;
                    String email = session.getAttribute("email").toString();
                    try {
                        con = Database.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery("select * from reg where email='" + email + "'");
                        if (rs.next()) {
                            name = rs.getString("name");
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                %>
                <center><h1 style="color: white">Verification System</h1></center>
                <div style="margin-top: 50px;color: white">
                    <center><h1>Bio-Metric Process</h1></center><br />
                    <form style="margin-top: 10px;width: 500px;height:200px;margin-left: 300px;" action="FingerVerification" method="post" enctype="multipart/form-data"> 
                        <label style="font-size: 20px;">Name</label>&nbsp;&nbsp;<input type="text" name="name" value="<%=name%>" readonly="" class="textbox" required=""  style="width: 200px;height: 18px;font-size: 15px;margin-left: 103px;"/><br /><br />
                        <label style="font-size: 20px;">Finger Image</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" name="file" class="textbox" required="" style="width: 200px;height: 18px;font-size: 15px;margin-left: 33px;" /><br /><br />
                        <input type="submit" value="Submit" style="margin-left: 150px;width: 100px;height: 30px;border-radius: 4px;background: white;border-top-color: red;border-bottom-color: yellow"/>
                        <input type="hidden" value="1" name="status" /><br/><br/>
                        <a href="diffuser.jsp">Login as  different user</a>
                    </form> 
                    <img src="images/finger.gif" width="150" height="200" style="float: right;margin-top: -280px;margin-right: 100px;"/>
                </div>
            </div><!--close site_content-->  	
             <footer>
                <br /><br />
            </footer>

        </div><!--close main-->
        <!-- javascript at the bottom for fast page loading -->
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/image_slide.js"></script>
        <script type="text/javascript" src="js/timer.js"></script>
    </body>
</html>

