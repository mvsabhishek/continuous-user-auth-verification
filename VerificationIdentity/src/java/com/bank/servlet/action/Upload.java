/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bank.servlet.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author java2
 */
public class Upload extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String pass = null;
            String txpass = null;
            String name = null;
            String gender = null;
            String dob = null;
            String acno = null;
            String bname = null;
            String address = null;
            String cno = null;
            String email = null;
            String msg = null;
            int money=1000;
            boolean isMultipartContent = ServletFileUpload.isMultipartContent(request);
            if (!isMultipartContent) {
                return;
            }
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            try {
                List<FileItem> fields = upload.parseRequest(request);
                Iterator<FileItem> it = fields.iterator();
                if (!it.hasNext()) {

                    return;
                }
                while (it.hasNext()) {
                    FileItem fileItem = it.next();

                    if (fileItem.getFieldName().equals("name")) {
                        name = fileItem.getString();
                    } else if (fileItem.getFieldName().equals("gender")) {
                        gender = fileItem.getString();
                    } else if (fileItem.getFieldName().equals("dob")) {
                        dob = fileItem.getString();
                    } else if (fileItem.getFieldName().equals("acno")) {
                        acno = fileItem.getString();
                        System.out.println("The Account No " + acno);
                    } else if (fileItem.getFieldName().equals("bank")) {
                        bname = fileItem.getString();
                    } else if (fileItem.getFieldName().equals("address")) {
                        address = fileItem.getString();
                    } else if (fileItem.getFieldName().equals("cno")) {
                        cno = fileItem.getString();
                    } else if (fileItem.getFieldName().equals("email")) {
                        email = fileItem.getString();
                    } else {
                    }
                    boolean isFormField = fileItem.isFormField();
                    if (isFormField) {
                    } else {
                        try {
                            pass = UUID.randomUUID().toString().substring(0, 5);
                            txpass = UUID.randomUUID().toString().substring(0, 7);
                            Connection cn = Database.getConnection();
                            PreparedStatement ps = cn.prepareStatement("insert into reg(name, pass, gender, dob, acno, bname, address, cno, email, money,pimage,tpass,rcount,status)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                            ps.setString(1, name);
                            ps.setString(2, pass);
                            ps.setString(3, gender);
                            ps.setString(4, dob);
                            ps.setString(5, acno);
                            ps.setString(6, bname);
                            ps.setString(7, address);
                            ps.setString(8, cno);
                            ps.setString(9, email);
                            ps.setInt(10, money);
                            ps.setBinaryStream(11, fileItem.getInputStream());
                            ps.setString(12, txpass);
                            ps.setInt(13, 0);
                            ps.setString(14, "Yes");
                            int i = ps.executeUpdate();
                            if (i == 1) {
                                msg = "Registration Successfully \n\n Welcome " + name + ",\n\n \tUser id :" + email + "\n\n \tAccount Password :" + pass+"\n\n\t Transaction Password  :"+txpass;
                                mail_Senddd m = new mail_Senddd();
                                m.sendMail(msg, "0109033mvsr@gmail.com", email);
                                HttpSession session = request.getSession();
                                session.setAttribute("email", email);
                                response.sendRedirect("fupload.jsp?msg=success");
                            } else {
                                response.sendRedirect("reg.jsp?msgg=failed");
                            }
                            cn.close();
                        } catch (ClassNotFoundException | SQLException | IOException | NumberFormatException e) {
                            out.println(e.toString());
                        }
                    }

                }
            } catch (FileUploadException e) {
            } catch (Exception ex) {
                Logger.getLogger(Upload.class.getName()).log(Level.SEVERE, null, ex);
            }
            /*Coding Ending*/
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
