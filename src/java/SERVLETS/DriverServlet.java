package SERVLETS;

import DAO.DBConnection;
import DAO.Booking_MegacityDAO;
import MODEL.Booking_Megacity;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DriverServlet", urlPatterns = {"/DriverServlet"})
public class DriverServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer driverId = (Integer) session.getAttribute("driver_id");

        // Redirect to login if driver is not authenticated
        if (driverId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection connection = DBConnection.getConnection()) {
            Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);
            
            // Fetch bookings assigned to the driver
//            List<Booking_Megacity> driverBookings = bookingDAO.getBookingsForDriver(driverId);
            
            // Set bookings as a request attribute
//            request.setAttribute("driverBookings", driverBookings);

            // Check for any success or error messages
            String successMessage = (String) session.getAttribute("successMessage");
            String errorMessage = (String) session.getAttribute("errorMessage");

            if (successMessage != null) {
                request.setAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage"); // Clear the success message after display
            }

            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
                session.removeAttribute("errorMessage"); // Clear the error message after display
            }

        } catch (Exception e) {
            // Log the error and set an error message
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching bookings. Please try again later.");
        }

        // Forward to the JSP page to display bookings
        request.getRequestDispatcher("DriverBookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer driverId = (Integer) session.getAttribute("driver_id");

        // Redirect to login if driver is not authenticated
        if (driverId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        try (Connection connection = DBConnection.getConnection()) {
            Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);

            // Update booking status based on the action
            if ("approve".equals(action)) {
//                bookingDAO.updateBookingStatus(bookingId, "approved");
                session.setAttribute("successMessage", "Booking approved successfully.");
            } else if ("reject".equals(action)) {
//                bookingDAO.updateBookingStatus(bookingId, "rejected");
                session.setAttribute("successMessage", "Booking rejected successfully.");
            } else {
                session.setAttribute("errorMessage", "Invalid action.");
            }
        } catch (Exception e) {
            // Log the error and set an error message
            e.printStackTrace();
            session.setAttribute("errorMessage", "An error occurred while processing your request. Please try again later.");
        }

        // Redirect back to the DriverServlet to refresh the bookings list
        response.sendRedirect("DriverServlet");
    }
}
