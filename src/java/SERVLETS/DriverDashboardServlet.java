package SERVLETS;

import DAO.DBConnection;
import DAO.DriverDashboardDAO;
import MODEL.Booking_Megacity;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DriverDashboardServlet")
public class DriverDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DriverDashboardServlet - doGet method started");
        
        Connection connection = null;
        connection = DBConnection.getConnection();
        if (connection != null) {
            System.out.println("Connection obtained successfully");
            
            DriverDashboardDAO bookingDAO = new DriverDashboardDAO(connection);
            List<Booking_Megacity> allBookings = bookingDAO.getAllBookings();
            
            System.out.println("Retrieved " + allBookings.size() + " bookings from database");
            
            // Set the bookings as a request attribute
            request.setAttribute("driverBookings", allBookings);
            
            System.out.println("Forwarding to DriverDashboard.jsp");
            request.getRequestDispatcher("PAGES/DriverDashboard.jsp").forward(request, response);
        } else {
            System.out.println("Failed to obtain database connection");
            request.setAttribute("errorMessage", "Failed to connect to database");
            request.getRequestDispatcher("PAGES/ErrorPage.jsp").forward(request, response);
        }
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed");
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}