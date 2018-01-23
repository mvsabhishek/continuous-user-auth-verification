<%@page import="com.bank.servlet.action.mail_Senddd"%>
<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    Connection con = null;
    Statement st = null;
    Statement st1 = null;
    Statement st2 = null;
    Statement st3 = null;
    Statement st4 = null;
    Statement st5 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    String[] data = request.getQueryString().split(",");
    String tname = data[2];
    System.out.println("Tname in Transfer "+tname);
    String tacno = data[3];
    System.out.println("Tacno in Transfer "+tacno);
//    long cdata1 = Long.parseLong(data[1]);
//    System.out.println("Data[1] " + cdata1);
//    long cdata2 = Long.parseLong(data[3]);
//    System.out.println("Data[3] " + cdata2);
    int money = 0, newmoney = 0, ndata = 0;
    ndata = Integer.parseInt(data[4]);
    System.out.println("The Transfer Amount " + ndata);
    try {
        if (data[1].equals(data[3])) {
            con = Database.getConnection();
            st = con.createStatement();
            rs = st.executeQuery("select * from reg where name='" + data[0] + "' AND acno='" + data[1] + "'");
            if (rs.next()) {
                money = rs.getInt("money");
                money = money + ndata;
                st1 = con.createStatement();
                int i = st1.executeUpdate("update reg set money='" + money + "' where name='" + data[0] + "' AND acno='" + data[1] + "'");
                if (i != 0) {
                    st3 = con.createStatement();
                   
                    int j = st3.executeUpdate("update ntransaction set status='Yes' where fname='" + data[0] + "' AND facno='" + data[1] + "' AND tacno='"+data[3]+"'");
                    if(j!=0)
                    {
                        System.out.println("Within First condition");
                        String msg = "Hi "+data[0]+",\n\n\t Your transaction successfully";
                        mail_Senddd m = new mail_Senddd();
                        m.transactionMail(msg, "010933mvsr@gmail.com",rs.getString("email") );
                        
                    }
                    response.sendRedirect("transaction.jsp?msg=success");
                } else {
                    response.sendRedirect("transaction.jsp?msgg=failed");
                }
            }
        } else {
            con = Database.getConnection();
            st = con.createStatement();
            rs = st.executeQuery("select * from reg where name='" + data[0] + "' AND acno='" + data[1] + "'");
            if (rs.next()) {
                money = rs.getInt("money");
                System.out.println("Available Amount " + money);
                if (money > ndata) {
                    newmoney = money - Integer.parseInt(data[4]);
                    System.out.println("New Available Amount " + newmoney);
                    st1 = con.createStatement();
                    st1.executeUpdate("update reg set money='" + newmoney + "' where name='" + data[0] + "' AND acno='" + data[1] + "'");
                    /*Start*/
                    System.out.println("in else 1");
                    st2 = con.createStatement();
                    System.out.println("in else 1+1");
                    rs1 = st2.executeQuery("select * from reg where name='" + tname + "' AND acno='" + tacno + "'");
                    if (rs1.next()) {
                        money = rs.getInt("money");
                        newmoney = money + ndata;
                        System.out.println("in else 2");
                        int i = st2.executeUpdate("update reg set money='" + newmoney + "' where name='" + data[2] + "' AND acno='" + data[3] + "'");
                        if (i != 0) {
                            st3 = con.createStatement();
                            int j = st3.executeUpdate("update ntransaction set status='Yes' where fname='" + data[0] + "' AND facno='" + data[1] + "' AND tname='" + data[2] + "'");
                            if (j != 0) {
                                System.out.println("Within First condition");
                        String msg = "Hi "+data[0]+",\n\n\t Your transaction successfully";
                        mail_Senddd m = new mail_Senddd();
                        m.transactionMail(msg, "010933mvsr@gmail.com",rs.getString("email") );
                                
                            }
                        }
                       response.sendRedirect("transaction.jsp?msg=success"); 
                    }
                    /*End*/
                } else {
                    response.sendRedirect("transaction.jsp?msgg=failed");
                }
            }
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>