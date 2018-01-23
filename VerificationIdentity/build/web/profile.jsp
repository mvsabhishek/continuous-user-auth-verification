<%@page import="java.util.Date"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
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
    String email = session.getAttribute("email").toString();
                    try {
                        con = Database.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery("select logging from reg where email='" + email + "'");
                        while(rs.next()){
                        if(rs.getInt("logging")=='0')
                        {
                            response.sendRedirect("user.jsp");  
                        }}
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
    </head>
    <body>
        <div id="main">		
            <header>
                <div id="strapline">
                    <div id="welcome_slogan">
                        <center><label style="font-size: 28px;color: white">Continuous User Identity Verification for <br />Secure Internet Services</label></center>
                    </div><!--close welcome_slogan-->
                </div><!--close strapline-->	  
                <nav>
                    <div id="menubar">
                        <ul id="nav">
                            <li class="current"><a href="uhome.jsp">Home</a></li>
                            <li><a href="profile.jsp">Profile</a></li>
                            <li><a href="account.jsp">Account</a></li>
                            <li><a href="beneficial.jsp">Beneficial</a></li>
                            <li><a href="money.jsp">Money Transaction</a></li>
                            <li><a href="logout.jsp">Log Out</a></li>
                        </ul>
                    </div><!--close menubar-->	
                </nav>
            </header>
            <div id="site_content" style="height: 380px;">	
                <%
                    InputStream n1 = null;
                    String logo = null;
                    int i = 1;
                    String email = session.getAttribute("email").toString();
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;
                    try {
                        con = Database.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery("select * from reg where email ='" + email + "'");
                        while (rs.next()) {
                %>
                <div style="margin-top: 20px;color: white;height: 365px;">
                    <center><h1>Profile Details</h1></center><br /><img src="disp_image.jsp" width="200" height="200" style="float: right;transform: rotateY(30deg);margin-right: 100px;"/>
                    <form style="margin-top: 10px;width: 500px;height:200px;margin-left: 300px;" action="loginaction.jsp" method="post"> 
                        <label style="font-size: 20px;">Name</label>&nbsp;&nbsp;<input type="text" value="<%=rs.getString("name")%>" class="textbox" readonly=""  style="width: 200px;height: 18px;font-size: 15px;margin-left: 54px;"/><br /><br />
                        <label style="font-size: 20px;">Gender</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=rs.getString("gender")%>" class="textbox" readonly="" style="width: 200px;height: 18px;font-size: 15px;margin-left: 35px;" /><br /><br />
                        <label style="font-size: 20px;">DOB</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=rs.getString("dob")%>" class="textbox" readonly="" style="width: 200px;height: 18px;font-size: 15px;;margin-left: 59px;" /><br /><br />
                        <label style="font-size: 20px;">Email</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=rs.getString("email")%>" class="textbox" readonly="" style="width: 200px;height: 18px;font-size: 15px;;margin-left: 53px;" /><br /><br />
                        <label style="font-size: 20px;">Ac.no</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=rs.getString("acno")%>" class="textbox" readonly=""  style="width: 200px;height: 18px;font-size: 15px;;margin-left: 52px;" /><br /><br />
                        <label style="font-size: 20px;">Bank Name</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text"  value="<%=rs.getString("bname")%>" class="textbox" readonly="" style="width: 200px;height: 18px;font-size: 15px;" /><br /><br />
                        <label style="font-size: 20px;">Location</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" value="<%=rs.getString("address")%>" class="textbox"  readonly="" style="width: 200px;height: 18px;font-size: 15px;margin-left: 30px;" /><br /><br />
                    </form>   
                </div>
                <%
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                %>
            </div><!--close site_content-->  
            <meta http-equiv="refresh" content="30;url=./index.html">
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

