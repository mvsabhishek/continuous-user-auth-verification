<%@page import="com.bank.servlet.action.mail_Senddd"%>
<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String[] data = request.getQueryString().split(",");
    Connection con = null;
    Statement st = null;
    int j=0;
    try {
        con = Database.getConnection();
        st = con.createStatement();
        int i = st.executeUpdate("update reg set status='Yes',rcount='"+j+"' where email ='" + data[0] + "' AND acno='" + data[1] + "'");
        if (i != 0) {
            String msg = "Hi, User,\n\n\t Your Account is activated";
            mail_Senddd m =new mail_Senddd();
            m.activateMail(msg, "010933mvsr@gmail.com", data[0]);
            response.sendRedirect("blocked.jsp?msg=success");
        } else {
            response.sendRedirect("blocked.jsp?msgg=failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }


%>