/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bank.servlet.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author java2
 */
public class Transaction extends HttpServlet {

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
            ResultSet rs = null;
            int status = Integer.parseInt(request.getParameter("status"));
            String femail = request.getSession().getAttribute("email").toString();
            String fname = request.getParameter("fname");
            String facno = request.getParameter("facno");
            String fbname = request.getParameter("fbname");
            String tname = request.getParameter("tname");
            String tmoney = request.getParameter("tmoney");
            String tacno = null, tbname = null, ifsc = null;
            Date now = new Date();
            SimpleDateFormat sf = new SimpleDateFormat("MM:dd:yy HH:mm:ss");
            String stime = sf.format(now);
            String tstatus = "No";
            try {
                con = Database.getConnection();
                switch (status) {
                    case 1:
                        try {
                            st = con.createStatement();
                            rs = st.executeQuery("select * from beneficial where tname='" + tname + "' AND bname='" + fbname + "' AND status='Yes'");
                            if (rs.next()) {
                                tbname = rs.getString("bname");
                                tacno = rs.getString("acno");
                                ifsc = rs.getString("ifsc");
                            }
                            int i = st.executeUpdate("insert into ntransaction(femail, fname, facno, fbname, tname, tbname, tacno, ifsccode, tmoney, stime, status)values('" + femail + "','" + fname + "','" + facno + "','" + fbname + "','" + tname + "','" + tbname + "','" + tacno + "','" + ifsc + "','" + tmoney + "','" + stime + "','" + tstatus + "')");
                            if (i != 0) {
                                response.sendRedirect("intertransaction.jsp?msg=success");
                            } else {
                                response.sendRedirect("intertransaction.jsp?msgg=failed");
                            }
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                        break;
                    case 2:
                        try {
                            st = con.createStatement();
                            rs = st.executeQuery("select * from beneficial where tname='" + tname + "' AND bname !='" + fbname + "' AND status='Yes'");
                            if (rs.next()) {
                                tbname = rs.getString("bname");
                                tacno = rs.getString("acno");
                                ifsc = rs.getString("ifsc");
                            }
                            int i = st.executeUpdate("insert into ntransaction(femail, fname, facno, fbname, tname, tbname, tacno, ifsccode, tmoney, stime, status)values('" + femail + "','" + fname + "','" + facno + "','" + fbname + "','" + tname + "','" + tbname + "','" + tacno + "','" + ifsc + "','" + tmoney + "','" + stime + "','" + tstatus + "')");
                            if (i != 0) {
                                response.sendRedirect("intratransaction.jsp?msg=success");
                            } else {
                                response.sendRedirect("intratransaction.jsp?msgg=failed");
                            }
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                        break;
                    default:
                        response.sendRedirect("uhome.jsp");
                }
            } catch (Exception ex) {
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
