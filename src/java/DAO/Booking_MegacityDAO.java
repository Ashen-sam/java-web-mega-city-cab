package DAO;


import MODEL.Booking_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Booking_MegacityDAO {
    private Connection connection;
    
    public  Booking_MegacityDAO(Connection connection) {
        this.connection = connection;
    }
    
    // Method to create a booking (updated to include status and price)
    public boolean createBooking(int customerRegId, int vehicleId, String pickup, String drop, 
                                 String bookingDate, String bookingTime, double price) {
        String insertSQL = "INSERT INTO bookings_megacity (customer_reg_id, vehicle_id, pickup_location, " +
                          "drop_location, booking_date, booking_time, price, status) VALUES (?, ?, ?, ?, ?, ?, ?, 'pending')";
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, customerRegId);
            preparedStatement.setInt(2, vehicleId);
            preparedStatement.setString(3, pickup);
            preparedStatement.setString(4, drop);
            preparedStatement.setString(5, bookingDate);
            preparedStatement.setString(6, bookingTime);
            preparedStatement.setDouble(7, price);
            
            return preparedStatement.executeUpdate() > 0; // Returns true if booking is successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Handle exceptions and return false if there is an error
        }
    }
    
    // For backward compatibility (old method without price)
    public boolean createBooking(int customerRegId, int vehicleId, String pickup, String drop, 
                                 String bookingDate, String bookingTime) {
        return createBooking(customerRegId, vehicleId, pickup, drop, bookingDate, bookingTime, 0.0);
    }
    
    // Method to get booking details by booking ID
    public ResultSet getBookingDetails(int bookingId) {
        String selectSQL = "SELECT * FROM bookings_megacity WHERE booking_id = ?";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, bookingId);
            return preparedStatement.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // Get the last inserted booking ID
    public int getLastBookingId() {
        String selectSQL = "SELECT MAX(booking_id) as last_id FROM bookings_megacity";
        try (PreparedStatement preparedStatement = connection.prepareStatement(selectSQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                return resultSet.getInt("last_id");
            }
            return -1; // No bookings found
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
    
    // Update price for an existing booking
    public boolean updateBookingPrice(int bookingId, double price) {
        String updateSQL = "UPDATE bookings_megacity SET price = ? WHERE booking_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(updateSQL)) {
            preparedStatement.setDouble(1, price);
            preparedStatement.setInt(2, bookingId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
// Get bookings assigned to a specific driver
public List<Booking_Megacity> getBookingsForDriver(int driverId) {
    List<Booking_Megacity> bookings = new ArrayList<>();
    String sql = "SELECT * FROM bookings_megacity WHERE vehicle_id IN " +
                 "(SELECT vehicle_id FROM vehicles_megacity WHERE driver_id = ?)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, driverId);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            bookings.add(new Booking_Megacity(
                rs.getInt("booking_id"),
                rs.getInt("customer_reg_id"),
                rs.getInt("vehicle_id"),
                rs.getString("pickup_location"),
                rs.getString("drop_location"),
                rs.getString("booking_date"), // Convert Date to String
                rs.getString("booking_time"), // Convert Time to String
                rs.getDouble("price"),
                rs.getString("status")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return bookings;
}

    
    // Update booking status (approve/reject)
    public boolean updateBookingStatus(int bookingId, String status) {
        String updateSQL = "UPDATE bookings_megacity SET status = ? WHERE booking_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(updateSQL)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, bookingId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
