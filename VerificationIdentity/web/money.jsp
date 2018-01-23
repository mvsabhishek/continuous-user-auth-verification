<%@page import="com.bank.servlet.action.mail_Senddd"%>
<%@page import="java.util.UUID"%>
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
                        int logging = 0;
                        while(rs.next()){
                        logging= rs.getInt("logging");
                        }
                        if(logging == 0)
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
            if (request.getParameter("msgg") != null) {%>
            <script>alert('Please enter correct otp and password');</script>
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
            <div id="site_content" style="height: 380px;color: white"><br /><br /><br />
                <%
                Connection con = null;
                Statement st = null;
                String otp = null;
                    String name = session.getAttribute("name").toString();
                    String email = session.getAttribute("email").toString();
                    try{
                        otp = UUID.randomUUID().toString().substring(0, 5);
                        con = Database.getConnection();
                        st = con.createStatement();
                        int i =st.executeUpdate("update reg set opass='"+otp+"' where email='"+email+"'");
                        if(i!=0)
                        {
                            String msg ="Hi "+name+",\n\n\t One Time Password :"+otp;
                            mail_Senddd m = new mail_Senddd();
                            m.otpMail(msg, "010933mvsr@gmail.com", email);
                        }
                    }
                    catch(Exception ex)
                    {
                        ex.printStackTrace();
                    }
                %>
                <img src="images/bank14.png" width="200" height="200" style="float: left;margin-left: 100px;"/>
                <form style="margin-top: 10px;width: 500px;height:200px;margin-left: 350px;" action="moneyverify.jsp" method="post"> 
                    <center><h1 style="margin-left: -200px">Verification System</h1></center><br /><br />
                    <label style="font-size: 20px;">Name</label>&nbsp;&nbsp;<input type="text" name="name" value="<%=name%>" readonly="" class="textbox" required=""  style="width: 200px;height: 18px;font-size: 15px;margin-left: 70px;"/><br /><br />
                    <label style="font-size: 20px;">Password</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="txpass"   class="textbox" required="" style="width: 200px;height: 18px;font-size: 15px;margin-left: 27px;" /><br /><br />
                    <label style="font-size: 20px;">OTP</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="otp"  required="" class="textbox"  style="width: 200px;height: 18px;font-size: 15px;;margin-left: 73px;" /><br /><br />
                    <input type="submit" value="Submit" style="margin-left: 70px;width: 100px;height: 30px;border-radius: 4px;background: white;border-top-color: red;border-bottom-color: yellow"/>
                    &nbsp; &nbsp; <input type="reset"  style="width: 100px;height: 30px;border-radius: 4px;background: white;border-top-color: red;border-bottom-color: yellow"/><br /><br />
                </form> 
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

