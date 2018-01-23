<%@page import="com.bank.servlet.action.Database"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  
         pageEncoding="ISO-8859-1"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">  
<html>
    <body>
        <%
            Blob image = null;
            Connection con = null;
            byte[] imgData = null;
            Statement stmt = null;
            ResultSet rs = null;
            String type = null;

            try {
                HttpSession user = request.getSession();
                String uname = user.getAttribute("email").toString();
                System.out.println("User mail in disp_image " + uname);
                con = Database.getConnection();
                stmt = con.createStatement();
                rs = stmt.executeQuery("select * from reg where email='" + uname + "' ");
                if (rs.next()) {
                    image = rs.getBlob("pimage");
                    imgData = image.getBytes(1, (int) image.length());

                } else {

                    out.println("Display Blob Example");
                    out.println("image not found for given id");
                    return;
                }

                // display the image
                response.setContentType("image/gif");
                OutputStream o = response.getOutputStream();
        %>
        <img src="<%o.write(imgData);%>" width="200" height="200">
        <%
                o.flush();
                o.close();

            } catch (Exception e) {

                out.println("Unable To Display image");
                out.println("Image Display Error=" + e.getMessage());
                return;

            } finally {

                try {

                    rs.close();
                    stmt.close();
                    con.close();
                } catch (SQLException e) {

                    e.printStackTrace();

                }

            }

        %>
    </body>
</html>