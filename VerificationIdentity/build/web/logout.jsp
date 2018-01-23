<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
if(session!=null)
       { 
  Connection con = null;
    Statement st = null;
    String email = session.getAttribute("email").toString();
                    try {
                        con = Database.getConnection();
                        st = con.createStatement();
                        st.executeUpdate("update reg set logging='0', finlog = '0' where email='" + email + "'");
                        } catch (Exception ex) {  
                        ex.printStackTrace();
                                           }        
            session.invalidate();
response.sendRedirect("index.html");
}
else
{
    response.sendRedirect("index.html");}
              
%>