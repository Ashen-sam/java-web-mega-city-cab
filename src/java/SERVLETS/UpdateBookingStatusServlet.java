package SERVLETS;

import DAO.Booking_MegacityDAO;
import DAO.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // Get parameters from the request
        String bookingIdStr = request.getParameter("bookingId");
        String status = request.getParameter("status");
        
        // Validate input
        if (bookingIdStr == null || status == null) {
            out.print("{\"success\": false, \"message\": \"Missing required parameters\"}");
            return;
        }
        
        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            
            // Map status from 'ACCEPT'/'REJECT' to your database values if needed
            String dbStatus;
            if ("ACCEPT".equals(status)) {
                dbStatus = "ACCEPTED"; // Change this to match your database status values
            } else if ("REJECT".equals(status)) {
                dbStatus = "REJECTED"; // Change this to match your database status values
            } else {
                out.print("{\"success\": false, \"message\": \"Invalid status value\"}");
                return;
            }
            
            // Update the booking status in the database
            try (Connection connection = DBConnection.getConnection()) {
                Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);
                boolean updated = bookingDAO.updateBookingStatus(bookingId, dbStatus);
                
                if (updated) {
                    out.print("{\"success\": true, \"message\": \"Booking status updated successfully\"}");
                } else {
                    out.print("{\"success\": false, \"message\": \"Failed to update booking status\"}");
                }
            } catch (SQLException e) {
                out.print("{\"success\": false, \"message\": \"Database error: " + escapeJsonString(e.getMessage()) + "\"}");
                e.printStackTrace();
            }
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Invalid booking ID format\"}");
        }
    }
    
    // Helper method to escape special characters in JSON
    private String escapeJsonString(String input) {
        if (input == null) {
            return "";
        }
        
        StringBuilder sb = new StringBuilder();
        for (char c : input.toCharArray()) {
            switch (c) {
                case '\"':
                    sb.append("\\\"");
                    break;
                case '\\':
                    sb.append("\\\\");
                    break;
                case '/':
                    sb.append("\\/");
                    break;
                case '\b':
                    sb.append("\\b");
                    break;
                case '\f':
                    sb.append("\\f");
                    break;
                case '\n':
                    sb.append("\\n");
                    break;
                case '\r':
                    sb.append("\\r");
                    break;
                case '\t':
                    sb.append("\\t");
                    break;
                default:
                    sb.append(c);
            }
        }
        return sb.toString();
    }
}