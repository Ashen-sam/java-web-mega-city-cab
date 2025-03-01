import DAO.Booking_MegacityDAO;
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
    private DBConnection dbDAO;

    @Override
    public void init() throws ServletException {
        dbDAO = new DBConnection();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");
        String date = request.getParameter("date");
        String vehicleType = request.getParameter("vehicleType");
        String price = request.getParameter("price"); // Get the calculated price
        String nic = request.getParameter("nic");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");

        try (Connection connection = dbDAO.getConnection()) {
            Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);
            
            // Example logic to get customer_reg_id and vehicle_id
            int customerRegId = getCustomerRegIdByNIC(nic, connection);
            
            // Get appropriate vehicle based on type selection
            int vehicleId = getAvailableVehicleByType(vehicleType, connection);
            
            // Create booking
            boolean bookingSuccess = bookingDAO.createBooking(customerRegId, vehicleId, pickup, drop, date, "10:00:00");
            
            if (bookingSuccess) {
                // Store the price in the booking record
                boolean priceUpdated = updateBookingPrice(bookingDAO.getLastBookingId(), price, connection);
                
                if (priceUpdated) {
                    request.setAttribute("message", "Booking successful! Your fare is " + price);
                } else {
                    request.setAttribute("message", "Booking successful! But there was an issue storing the price.");
                }
            } else {
                request.setAttribute("message", "Booking failed. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your booking.");
        }
        
        // Forward to a JSP page to display the result
//        request.getRequestDispatcher("booking-result.jsp").forward(request, response);
    }

    private int getCustomerRegIdByNIC(String nic, Connection connection) {
        // Implement logic to fetch customer_reg_id from NIC
        return 1; // Placeholder
    }

    private int getAvailableVehicleByType(String vehicleType, Connection connection) {
        // Implement logic to find an available vehicle of the specified type
        return 1; // Placeholder
    }
    
    private boolean updateBookingPrice(int bookingId, String price, Connection connection) {
        // Implement logic to update the booking with the calculated price
        // This would require adding a 'price' column to your bookings_megacity table
        return true; // Placeholder
    }
}