<%@page import="java.sql.ResultSet"%>
<%@page import="com.bank.servlet.action.mail_Senddd"%>
<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String[] data = request.getQueryString().split(",");
    Connection con = null;
    Statement st = null;
    Statement st1 = null;
    ResultSet rs = null;
    String msg = null;
    try {
        con = Database.getConnection();
        st = con.createStatement();
        int i = st.executeUpdate("update beneficial set status='Yes' where aemail='" + data[0] + "' AND acno='" + data[1] + "'");
        if (i != 0) {
            st1 = con.createStatement();
            rs = st1.executeQuery(" select * from reg where email = '"+data[0]+"'");
            if (rs.next()) {
                msg ="Hi "+rs.getString("name")+"\n\n\t Beneficial Activated \n\n";
                mail_Senddd m = new mail_Senddd();
                m.beneficialMail(msg, "010933mvsr@gmail.com", data[0]);
                response.sendRedirect("beneficialdetails.jsp?msg=success");
            }
        } else {
            response.sendRedirect("beneficialdetails.jsp?msgg=failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>