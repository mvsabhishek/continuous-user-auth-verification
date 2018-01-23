<%@page import="java.sql.ResultSet"%>
<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;
    String name = request.getParameter("name");
    System.out.println("The name in moneyverify " + name);
    String pass = request.getParameter("txpass");
    System.out.println("The txpass in moneyverify " + pass);
    String s = request.getParameter("otp");
    System.out.println("The otp in moneyverify " + s);
    try {
        con = Database.getConnection();
        st = con.createStatement();
        rs = st.executeQuery("select * from reg where name='" + name + "' AND tpass='" + pass + "' AND opass='"+s+"'");
        if (rs.next()) {
            response.sendRedirect("money1.jsp?msg=success");
        }
        else
        {
            response.sendRedirect("money.jsp?msgg=failed");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }


%>