/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package SERVLETS;

import DAO.BookingDataDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.System.Logger;
import java.sql.SQLException;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ashen Samarasekera
 */
@WebServlet(name = "BookingDataServlet", urlPatterns = {"/BookingDataServlet"})
public class BookingDataServlet extends HttpServlet {
    
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
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String bookingIdParam = request.getParameter("bookingId");
        
        if (bookingIdParam == null || bookingIdParam.isEmpty()) {
            session.setAttribute("error", "Booking ID is required");
            response.sendRedirect(request.getContextPath() + "/PAGES/DriverDashboard.jsp");
            return;
        }
        
        int bookingId;
        try {
            bookingId = Integer.parseInt(bookingIdParam);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid booking ID format");
            response.sendRedirect(request.getContextPath() + "/PAGES/DriverDashboard.jsp");
            return;
        }
        
        try {
            boolean success = false;
            String message = "";
            
            switch (action.toLowerCase()) {
                case "approved":
                    success = BookingDataDAO.updateBookingStatus(bookingId, "APPROVED");
                    message = success ? "Booking #" + bookingId + " has been accepted successfully" : "Failed to accept booking";
                    break;
                    
                case "reject":
                    success = BookingDataDAO.updateBookingStatus(bookingId, "REJECTED");
                    message = success ? "Booking #" + bookingId + " has been rejected" : "Failed to reject booking";
                    break;
                    
                case "delete":
                    success = BookingDataDAO.deleteBooking(bookingId);
                    message = success ? "Booking #" + bookingId + " has been deleted" : "Failed to delete booking";
                    break;
                    
                default:
                    session.setAttribute("error", "Invalid action requested");
                    response.sendRedirect(request.getContextPath() + "/PAGES/DriverDashboard.jsp");
                    return;
            }
            
            if (success) {
                session.setAttribute("message", message);
            } else {
                session.setAttribute("error", message);
            }
            
        } catch (SQLException | ClassNotFoundException e) {
//            LOGGER.log(Level.SEVERE, "Database error while processing booking action", e);
            session.setAttribute("error", "Database error: " + e.getMessage());
        }
        
        // Redirect back to the dashboard
        response.sendRedirect(request.getContextPath() + "/PAGES/DriverDashboard.jsp");
    }
}