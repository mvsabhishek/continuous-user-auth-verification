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
            if (request.getParameter("msg") != null) {%>
        <script>alert('Money Transfer successfully');</script>
        <% }
            if (request.getParameter("msgg") != null) {%>
        <script>alert('Money Transfer failed');</script> 
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
            <div id="site_content" style="height: 400px;"><br /><br /><br />
                <a href="money1.jsp" style="text-decoration: none">Back</a>
                <%
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;
                    String name = null;
                    String bname = null;
                    String acno = null;
                    String email = session.getAttribute("email").toString();
                    try {
                        con = Database.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery("select * from reg where email='" + email + "'");
                        if (rs.next()) {
                            name = rs.getString("name");
                            acno = rs.getString("acno");
                            bname = rs.getString("bname");
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                %>
                <div style="color: white">
                    <center><h1>Inter Money Transfer Details</h1></center><br />
                    <form style="margin-top: 10px;margin-left: 50px;width: 800px;height:250px;" action="Transaction" method="post"> 
                        <div style="float: left;height:200px;">
                            <h1 style="margin-left: 100px;">From</h1><br />
                            <label style="font-size: 20px;">Name</label>&nbsp;&nbsp;<input type="text" name="fname" value="<%=name%>" readonly="" class="textbox" required=""  style="width: 200px;height: 18px;font-size: 15px;margin-left: 95px;"/><br /><br />
                            <label style="font-size: 20px;">Ac.no</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="facno" value="<%=acno%>" readonly="" class="textbox" required="" style="width: 200px;height: 18px;font-size: 15px;margin-left: 90px;" /><br /><br />
                            <label style="font-size: 20px;">Bank Name</label>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="fbname" value="<%=bname%>" required="" class="textbox" readonly="" style="width: 200px;height: 18px;font-size: 15px;;margin-left: 37px;" /><br /><br />
                        </div>
                        <div style="float: right;height:200px;">
                            <h1 style="margin-left: 100px;">To</h1><br />
                            <label style="font-size: 20px;">Name</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <select class="textbox" name="tname" style="width: 200px;height: 22px;font-size: 15px;;margin-left: 74px;" >
                                <%
                                    Statement st1 = null;
                                    ResultSet rs1 = null;
                                    try {
                                        con = Database.getConnection();
                                        st1 = con.createStatement();
                                        rs1 = st.executeQuery("select * from beneficial where aemail='" + email + "' AND status='Yes' AND bname !='" + bname + "'");
                                        while (rs1.next()) {
                                %>
                                <option><%=rs1.getString("tname")%></option>
                                <%
                                        }
                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    }
                                %>
                            </select><br /><br />
                            <label style="font-size: 20px;">Transfer Money</label>&nbsp;&nbsp;<input type="text" name="tmoney"  value="" class="textbox" required=""  style="width: 200px;height: 18px;font-size: 15px;"/><br /><br />
                        </div>
                        <input type="hidden" value="2" name="status" />
                        <input type="submit" value="Transfer" style="margin-left: 250px;width: 100px;height: 30px;border-radius: 4px;background: white;border-top-color: red;border-bottom-color: yellow"/>
                        &nbsp; &nbsp; <input type="reset"  style="width: 100px;height: 30px;border-radius: 4px;background: white;border-top-color: red;border-bottom-color: yellow"/><br /><br />
                    </form> 
                    <meta http-equiv="refresh" content="30;url=./index.html">
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

