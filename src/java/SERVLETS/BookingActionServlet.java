/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package SERVLETS;

import DAO.BookingDataDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ashen Samarasekera
 */// BookingActionServlet.java
@WebServlet("/BookingActionServlet")
public class BookingActionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        
        try {
            if ("approve".equals(action)) {
                // Update booking status to "Approved"
                boolean updated = BookingDataDAO.updateBookingStatus(bookingId, "Approved");
                if (updated) {
                    session.setAttribute("message", "Booking #" + bookingId + " has been approved.");
                } else {
                    session.setAttribute("error", "Failed to approve booking.");
                }
            } else if ("cancel".equals(action)) {
                // Update booking status to "Rejected"
                boolean updated = BookingDataDAO.updateBookingStatus(bookingId, "Rejected");
                if (updated) {
                    session.setAttribute("message", "Booking #" + bookingId + " has been rejected.");
                } else {
                    session.setAttribute("error", "Failed to reject booking.");
                }
            }
        } catch (Exception e) {
            session.setAttribute("error", "Error: " + e.getMessage());
        }
        
        // Redirect back to the driver dashboard
        response.sendRedirect(request.getContextPath() + "/PAGES/DriverDashboard.jsp");
    }
}