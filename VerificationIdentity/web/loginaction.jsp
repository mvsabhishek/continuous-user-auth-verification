<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
    Connection con = null;
    Statement st = null;
    Statement st1 = null;
    Statement st2 = null;
    ResultSet rs = null;
    int rcount = 0;
    String otp = UUID.randomUUID().toString().substring(0, 4);
    String username = request.getParameter("user");
    String password = request.getParameter("pass");
    int status = Integer.parseInt(request.getParameter("status"));
    try {
        switch (status) {
            case 1:
                try {
                    con = Database.getConnection();
                    st = con.createStatement();
                    rs = st.executeQuery("select * from reg where email='" + username + "'");
                    if (rs.next()) {
                        if (rs.getString("pass").equals(password) && rs.getString("status").equals("Yes")) {
                            session.setAttribute("email", rs.getString("email"));
                            session.setAttribute("name", rs.getString("name"));
                            session.setAttribute("bank", rs.getString("bname"));
                            st2 = con.createStatement();
                            int i = st2.executeUpdate("update reg set finlog = '1', opass='" + otp + "' where email='" + username + "'");
                            if (i != 0) {
                                response.sendRedirect("fingeraction.jsp?msg=success");
                            }
                        } else if (rs.getString("pass").equals(password) && rs.getString("status").equals("No")) {
                            response.sendRedirect("user.jsp?bmsg=Blocked");
                        } else {
                            rcount = rs.getInt("rcount") + 1;
                            System.out.println("Count Is " + rcount);
                            if (rcount <= 2) {
                                st1 = con.createStatement();
                                st1.executeUpdate("update reg set rcount='" + rcount + "' where email='" + username + "'");
                                response.sendRedirect("user.jsp?msgg=failed");
                            } else {
                                Date now = new Date();
                                SimpleDateFormat sf = new SimpleDateFormat("MM:dd:yyy HH:mm:ss");
                                st1 = con.createStatement();
                                st1.executeUpdate("update reg set rcount='" + rcount + "',status='No',btime='" + sf.format(now) + "' where email='" + username + "'");
                                response.sendRedirect("user.jsp?msgg=failed");
                            }
                        }
                    } else {
                        response.sendRedirect("user.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            case 2:
                try {
                    if (username.equalsIgnoreCase("server") && password.equalsIgnoreCase("server")) {
                        session.setAttribute("name","server");
                        response.sendRedirect("shome.jsp?msg=success");
                    } else {
                        response.sendRedirect("server.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            default:
                response.sendRedirect("index.html");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>