<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%

    Connection con = null;
    Statement st = null;
    Statement st1 = null;
    ResultSet rs = null;
    String email = session.getAttribute("email").toString();
    String oldPass = request.getParameter("oldPass");
    String newPass = request.getParameter("newPass");
    int status = Integer.parseInt(request.getParameter("status"));

    switch (status) {
        case 1:
            try {
                con = Database.getConnection();
                st = con.createStatement();
                rs = st.executeQuery("select * from reg where email='" + email + "' AND pass='" + oldPass + "' ");
                if (rs.next()) {
                    st1 = con.createStatement();
                    int i = st1.executeUpdate("update reg set pass='" + newPass + "' where email='" + email + "' AND pass='" + oldPass + "' ");
                    if (i != 0) {
                        response.sendRedirect("acpassword.jsp?msg=success");
                    }
                } else {
                    response.sendRedirect("acpassword.jsp?msgg=failed");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            break;
        case 2:
            try {
                con = Database.getConnection();
                st = con.createStatement();
                rs = st.executeQuery("select * from reg where email='" + email + "' AND tpass='" + oldPass + "' ");
                if (rs.next()) {
                    st1 = con.createStatement();
                    int i = st1.executeUpdate("update reg set tpass='" + newPass + "' where email='" + email + "' AND tpass='" + oldPass + "' ");
                    if (i != 0) {
                        response.sendRedirect("txpassword.jsp?msg=success");
                    }
                } else {
                    response.sendRedirect("txpassword.jsp?msgg=failed");
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            break;
        default:
            response.sendRedirect("index.html");
    }
%>