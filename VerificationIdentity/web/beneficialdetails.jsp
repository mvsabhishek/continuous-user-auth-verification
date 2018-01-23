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
            <%
                if (request.getParameter("msg") != null) {%>
            <script>alert('Beneficial Details Sent');</script>
            <%}
                if (request.getParameter("msgg") != null) {%>
            <script>alert('Beneficial Activation Failed');</script>
            <%}
            %>
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
                <div style="margin-top: 40px;color: white">
                    <center><h1>Beneficial Request Details</h1></center>  <br />
                    <table style="text-align: center;margin-left: 40px;font-size: 15px" border="1">
                        <tr>
                            <th>Debitor Email</th>
                            <th>Debitor Bank</th>
                            <th>Creator Name</th>
                            <th>Creditor Bank</th>
                            <th>Ac.no</th>
                            <th>IFSC Code</th>
                            <th>Request Time</th>
                            <th>Action</th>
                        </tr>
                        <tr>
                            <%                                Connection con = null;
                                Statement st = null;
                                ResultSet rs = null;
                                try {
                                    con = Database.getConnection();
                                    st = con.createStatement();
                                    rs = st.executeQuery("select * from beneficial where status='No'");
                                    while (rs.next()) {%>
                            <td><%=rs.getString("aemail")%></td>
                            <td><%=rs.getString("fbname")%></td>
                            <td><%=rs.getString("tname")%></td>
                            <td><%=rs.getString("bname")%></td>
                            <td><%=rs.getString("acno")%></td>
                            <td><%=rs.getString("ifsc")%></td>
                            <td><%=rs.getString("rtime")%></td>
                            <td><a href="beneficialactivation.jsp?<%=rs.getString("aemail")%>,<%=rs.getString("acno")%>" style="text-decoration: none">Activate</a></td>
                            <td><a href="beneficialdeact.jsp?<%=rs.getString("aemail")%>,<%=rs.getString("acno")%>" style="text-decoration: none">Reject</a></td>
                        </tr>
                        <%}
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        %>
                    </table>  
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

