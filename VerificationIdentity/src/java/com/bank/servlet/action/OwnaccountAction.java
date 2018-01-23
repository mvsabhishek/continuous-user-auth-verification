/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bank.servlet.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author java2
 */
public class OwnaccountAction extends HttpServlet {

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
            Connection con = null;
            Statement st = null;
            String ifsc = null;
            String email = request.getSession().getAttribute("email").toString();
            String name = request.getParameter("name");
            String acno = request.getParameter("acno");
            String bname = request.getParameter("bname");
            int deposit = Integer.parseInt(request.getParameter("deposit"));
            String ran = UUID.randomUUID().toString().substring(0, 3).toUpperCase();
            Date now = new Date();
            SimpleDateFormat sf = new SimpleDateFormat("MM:dd:yyy HH:mm:ss");
            String stime = sf.format(now);
            try {
                System.out.println("The Verification is "+email);
                if (bname.equals("SBI")) {
                    ifsc = bname + "10251" + ran;
                } else if (bname.equals("Indian Bank")) {
                    ifsc = bname + "12754" + ran;
                } else if (bname.equals("ICICI")) {
                    ifsc = bname + "01456" + ran;
                } else if (bname.equals("KVB")) {
                    ifsc = bname + "85742" + ran;
                } else {
                    ifsc = bname + "72458" + ran;
                }
                con = Database.getConnection();
                st = con.createStatement();
                int i = st.executeUpdate("insert into ntransaction(femail, fname, facno, fbname, tname, tbname, tacno, ifsccode, tmoney, stime, status) values('" + email + "','" + name + "','" + acno + "','" + bname + "','" + name + "','" + bname + "','" + acno + "','" + ifsc + "','" + deposit + "','" + stime + "','No')");
                if (i != 0) {
                    response.sendRedirect("ownaccount.jsp?msg=success");
                } else {
                    response.sendRedirect("ownaccount.jsp?msgg=failed");
                }
            } catch (ClassNotFoundException | SQLException ex) {
                ex.printStackTrace();
            }
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
