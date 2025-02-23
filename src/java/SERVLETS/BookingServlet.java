package servlet;

import DAO.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bookVehicle")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from request
     
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        String bookingDate = request.getParameter("bookingDate");
        String bookingTime = request.getParameter("bookingTime");

        // Database connection
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO bookings_megacity ( pickup_location, drop_location, booking_date, booking_time) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(3, pickupLocation);
            statement.setString(4, dropLocation);
            statement.setString(5, bookingDate);
            statement.setString(6, bookingTime);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                request.setAttribute("message", "Booking successful!");
            } else {
                request.setAttribute("message", "Booking failed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error occurred: " + e.getMessage());
        }

        // Forwarding to the result JSP
        request.getRequestDispatcher("bookingResult.jsp").forward(request, response);
    }
}
