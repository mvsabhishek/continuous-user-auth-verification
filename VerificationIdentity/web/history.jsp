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
        <script>alert('Beneficial Details added successfully');</script>
        <% }
            if (request.getParameter("msgg") != null) {%>
        <script>alert('Beneficial Details added failed');</script> 
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
            <div id="site_content" style="height: 380px;">
                <div style="margin-top: 50px;color: white">
                    <a href="account.jsp" style="text-decoration: none">Back</a>
                    <center><h1>Transaction Details</h1></center><br />
                    <table border="1" style="text-align: center;margin-left: 200px;">
                        <tr>
                            <th>From Name</th>
                            <th>To Name</th>
                            <th>To Bank Name</th>
                            <th>To Ac.no</th>
                            <th>Money</th>
                            <th>Transaction Time</th>
                        </tr>
                        <tr>
                            <%
                                Connection con = null;
                                Statement st = null;
                                ResultSet rs = null;
                                String name = session.getAttribute("name").toString();
                                String email = session.getAttribute("email").toString();
                                try {
                                    con = Database.getConnection();
                                    st = con.createStatement();
                                    rs = st.executeQuery("select * from ntransaction where femail='" + email + "'");
                                    while (rs.next()) {%>
                            <td><%=rs.getString("fname")%></td>
                            <td><%=rs.getString("tname")%></td>
                            <td><%=rs.getString("tbname")%></td>
                            <td><%=rs.getString("tacno")%></td>
                            <td><%=rs.getInt("tmoney")%></td>
                            <td><%=rs.getString("stime")%></td>
                        </tr>
                        <%}
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        %>
                    </table><br />
                    <center><h1>Money Credited Details</h1></center><br />
                    <table border="1" style="text-align: center;margin-left: 200px;">
                        <tr>
                            <th>From Name</th>
                            <th>To Name</th>
                            <th>To Bank Name</th>
                            <th>To Ac.no</th>
                            <th>Money</th>
                            <th>Transaction Time</th>
                        </tr>
                        <tr>
                            <%
                                try {
                                    con = Database.getConnection();
                                    st = con.createStatement();
                                    rs = st.executeQuery("select * from ntransaction where tname='" + name + "'");
                                    while (rs.next()) {%>
                            <td><%=rs.getString("fname")%></td>
                            <td><%=rs.getString("tname")%></td>
                            <td><%=rs.getString("tbname")%></td>
                            <td><%=rs.getString("tacno")%></td>
                            <td><%=rs.getInt("tmoney")%></td>
                            <td><%=rs.getString("stime")%></td>
                        </tr>
                        <%}
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        %>
                    </table><br />
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

