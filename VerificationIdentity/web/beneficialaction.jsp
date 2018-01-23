<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.bank.servlet.action.mail_Senddd"%>
<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String msg = null;
    String email = session.getAttribute("email").toString();
    System.out.println("The email in beneficialaction " + email);
    String uname = session.getAttribute("name").toString();
    System.out.println("The name in beneficialaction " + uname);
    String name = request.getParameter("name");
    String acno = request.getParameter("acno");
    String bname = request.getParameter("bname");
    String ifsc = request.getParameter("ifsc");
    int bstatus = Integer.parseInt(request.getParameter("bstatus"));
    Connection con = null;
    Statement st = null;
    Date now = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("MM:dd:yyy HH:mm:ss");
    String rtime = sf.format(now);
    try {
        con = Database.getConnection();
        st = con.createStatement();
        switch (bstatus) {
            case 1:
                try {
                    int i = st.executeUpdate("insert into beneficial(aemail, fbname, tname, bname, acno, ifsc,rtime,status) values('" + email + "','" + bname + "','" + name + "','" + bname + "','" + acno + "','" + ifsc + "','" + rtime + "','No')");
                    if (i != 0) {
                        msg = "Hi " + uname + ",\n\n\t Beneficial Details sent, waiting for confimation within 24hrs.\n\n\t\tThanks,\n\t\tBank Manager";
                        mail_Senddd m = new mail_Senddd();
                        m.beneficialMail(msg, "010933mvsr@gmail.com", email);
                        response.sendRedirect("inter.jsp?msg=success");
                    } else {
                        response.sendRedirect("inter.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            case 2:
                try {
                    String fbname = session.getAttribute("bank").toString();
                    System.out.println("the from bank name "+fbname);
                    int i = st.executeUpdate("insert into beneficial(aemail, fbname, tname, bname, acno, ifsc,rtime, status) values('" + email + "','" + fbname + "','" + name + "','" + bname + "','" + acno + "','" + ifsc + "','" + rtime + "','No')");
                    if (i != 0) {
                        msg = "Hi " + uname + ",\n\n\t Beneficial Details sent, waiting for confimation within 24hrs.\n\n\t\tThanks,\n\t\tBank Manager";
                        mail_Senddd m = new mail_Senddd();
                        m.beneficialMail(msg, "010933mvsr@gmail.com", email);
                        response.sendRedirect("intra.jsp?msg=success");
                    } else {
                        response.sendRedirect("intra.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            default:
                response.sendRedirect("beneficial.jsp");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }


%>