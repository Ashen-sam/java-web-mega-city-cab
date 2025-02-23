import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Booking_MegacityDAO {
    private Connection connection;

    public Booking_MegacityDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to create a booking
    public boolean createBooking(int customerRegId, int vehicleId, String pickup, String drop, String bookingDate, String bookingTime) {
        String insertSQL = "INSERT INTO bookings_megacity (customer_reg_id, vehicle_id, pickup_location, drop_location, booking_date, booking_time) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {
            preparedStatement.setInt(1, customerRegId);
            preparedStatement.setInt(2, vehicleId);
            preparedStatement.setString(3, pickup);
            preparedStatement.setString(4, drop);
            preparedStatement.setString(5, bookingDate);
            preparedStatement.setString(6, bookingTime);

            return preparedStatement.executeUpdate() > 0; // Returns true if booking is successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Handle exceptions and return false if there is an error
        }
    }

    // Method to get booking details by booking ID (optional)
    public ResultSet getBookingDetails(int bookingId) {
        // Implement this method to retrieve booking details if needed
        return null;
    }
}
