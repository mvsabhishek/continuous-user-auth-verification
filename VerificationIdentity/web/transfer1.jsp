<%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
<%@page import="com.bank.servlet.action.mail_Senddd"%>
<%@page import="com.bank.servlet.action.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String transd = request.getParameter("transid");
    int trans = Integer.parseInt(transd);
    String fname = null; 
    String fbname=null;  
    String tname= null;
    String tbname= null; 
    String ifsccode = null;
    String femail = null;
    int fmoney = 0;
    int tmoney = 0;
    int bmoney = 0;
    String tacno = null;
    String facno = null;
    try {
            Connection con = null;
            Statement st = null; 
            Statement st1 = null;
            Statement st10 = null;
            con = Database.getConnection();
            st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from ntransaction where transid = " + trans );
            while (rs.next()) {
            fname = rs.getString("fname");
            femail = rs.getString("femail");
            facno = rs.getString("facno");
            fbname = rs.getString("fbname");
            tname = rs.getString("tname");
            tbname = rs.getString("tbname");
            tacno = rs.getString("tacno");
            ifsccode = rs.getString("ifsccode");
            tmoney = rs.getInt("tmoney");
            }
            System.out.println("1");
           st1= con.createStatement();
           st10= con.createStatement();
           boolean tr = st1.execute("select * from reg where acno = " + tacno);
           boolean tb = st10.execute("select * from beneficial where acno = " + tacno);
           //check if the receiver is also registered.
           if((tr == true) && (tb == true))
             {
               System.out.println("2");
              
               if(tacno.equals(facno)) //check if the receiver is himself the sender
               {
                System.out.println("3");
                Statement st2 = null;
                st2= con.createStatement();
                ResultSet rs1 = st2.executeQuery("select * from reg where acno = " + facno);
                while (rs1.next())
                {
                 fmoney = rs1.getInt("money");   
                } 
                fmoney = fmoney + tmoney;
                Statement st3 = null;
                Statement st4 = null;
                st3= con.createStatement();
                st4= con.createStatement();
                int i = st3.executeUpdate("update reg set money = " + fmoney + " where acno = '" + facno + "' AND name = '" + fname +"'");                                                                              
                if(i != 0){ //check if the transfer is done
                     System.out.println("4");
                    int j = st4.executeUpdate("update ntransaction set status='Yes' where transid = " + trans);                                                                              
                    System.out.println("own done");
                    if(j!=0)
                    {
                        System.out.println("Within First condition");
                        String msg = "Hi "+fname+",\n\n\t Your transaction is successful";
                        mail_Senddd m = new mail_Senddd();
                        m.transactionMail(msg, "010933mvsr@gmail.com",femail);
                        
                    }
                    response.sendRedirect("transaction.jsp?msg=success");
                               }
                               else{ //transfer done or not
                    System.out.println("own NOT done");
                    response.sendRedirect("transaction.jsp?msgg=failed");
                                   }
                               }
               else { // if not same account
                 System.out.println("5");
               
                Statement st5 = null;
                Statement st6 = null;
                st5= con.createStatement();
                st6= con.createStatement();
                ResultSet rs2 = st5.executeQuery("select * from reg where acno = " + facno);
                ResultSet rs3 = st6.executeQuery("select * from reg where acno = " + tacno);
                while (rs2.next())
                {
                 fmoney = rs2.getInt("money");   
                }
                while (rs3.next())
                {
                 bmoney = rs3.getInt("money");   
                } 
                if(fmoney > tmoney){
                 System.out.println("6");
               
                fmoney = fmoney -  tmoney;
                bmoney = bmoney + tmoney;
                Statement st7 = null;
                Statement st8 = null;
                st7= con.createStatement();
                st8= con.createStatement();
                System.out.println("Before update");
                int k = st7.executeUpdate("update reg set money = " + fmoney + " where name = '"+ fname +"' AND acno = '"+ facno +"'");
                int l = st8.executeUpdate("update reg set money = " + bmoney + " where name = '"+ tname +"' AND acno = '"+ tacno +"'");
                System.out.println("After Update");
                if((k != 0)&&(l != 0)){
                System.out.println("7");
                Statement st9 = null;
                st9 = con.createStatement();
                int n = st9.executeUpdate("update ntransaction set status='Yes' where transid = " + trans);                       
                System.out.println("tranfer done");
                if(n!=0)
                    {
                        System.out.println("Within First condition");
                        String msg = "Hi "+fname+",\n\n\t Your transaction is successful";
                        mail_Senddd m = new mail_Senddd();
                        m.transactionMail(msg, "010933mvsr@gmail.com",femail);
                        
                    }
                       response.sendRedirect("transaction.jsp?msg=Success");
                }
                else{ // update check
                 System.out.println("tranfer not done");
                       response.sendRedirect("transaction.jsp?msgg=failed");
                                             }
                }
                else{ // fmoney > tmoney
                 System.out.println("tranfer not done");
                       response.sendRedirect("transaction.jsp?msgg=failed");
                                             }
                }
                
               }
                             
               else if ((tr == false) && (tb == true)){
                    System.out.println("8");
                Statement st2 = null;
                st2= con.createStatement();
                ResultSet rs1 = st2.executeQuery("select * from reg where acno = " + facno);
                while (rs1.next())
                {
                 fmoney = rs1.getInt("money");   
                } 
                fmoney = fmoney - tmoney;
                Statement st3 = null;
                Statement st4 = null;
                st3= con.createStatement();
                st4= con.createStatement();
                int i = st3.executeUpdate("update reg set money = '" + fmoney + "' where acno = '" + facno + "' AND name = '" + fname +"'");                                                                              
                if(i != 0){ //check if the transfer is done
                     System.out.println("9");
                    int h = st4.executeUpdate("update ntransaction set status='Yes' where transid = " + trans);                                                                              
                    System.out.println("transfer done");
                    if(h!=0)
                    {
                        System.out.println("Within First condition");
                        String msg = "Hi "+fname+",\n\n\t Your transaction is successful";
                        mail_Senddd m = new mail_Senddd();
                        m.transactionMail(msg, "010933mvsr@gmail.com",femail);
                        
                    }
                    response.sendRedirect("transaction.jsp?msg=success");
                               }
                               else{ //transfer done or not
                    System.out.println("transfer NOT done");
                    response.sendRedirect("transaction.jsp?msgg=failed");
                                   }
                }
             else{ // fmoney > tmoney
                 System.out.println("tranfer not done");
                       response.sendRedirect("transaction.jsp?msgg=failed");
                                             }
                
                
                
    }
        catch (Exception ex) {
        ex.printStackTrace();
    }
    System.out.println("Transaction id is:"+trans);
%>            