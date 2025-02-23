import DAO.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private DBConnection dbDAO; // Assuming you have a DBDAO for database connections

    @Override
    public void init() throws ServletException {
        dbDAO = new DBConnection(); // Initialize your DBDAO here (ensure it handles connection)
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");
        String date = request.getParameter("date");
        String nic = request.getParameter("nic");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");

        try (Connection connection = dbDAO.getConnection()) { // Get the connection from DBDAO
            Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);

            // Example logic to get customer_reg_id and vehicle_id
            int customerRegId = getCustomerRegIdByNIC(nic, connection); // Implement this method
            int vehicleId = getAvailableVehicleId(connection); // Implement this method

            // Create booking
            boolean bookingSuccess = bookingDAO.createBooking(customerRegId, vehicleId, pickup, drop, date, "10:00:00"); // Example time

            if (bookingSuccess) {
                request.setAttribute("message", "Booking successful!");
            } else {
                request.setAttribute("message", "Booking failed. Please try again.");
            }

            // Optionally, retrieve booking details if necessary
            // ResultSet bookingDetails = bookingDAO.getBookingDetails(bookingId); // Implement this if needed
            // request.setAttribute("bookingDetails", bookingDetails);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your booking.");
        }

        // Forward to a JSP page to display the result
        request.getRequestDispatcher("booking-result.jsp").forward(request, response);
    }

    private int getCustomerRegIdByNIC(String nic, Connection connection) {
        // Implement logic to fetch customer_reg_id from NIC
        return 1; // Placeholder
    }

    private int getAvailableVehicleId(Connection connection) {
        // Implement logic to find an available vehicle
        return 1; // Placeholder
    }
}
