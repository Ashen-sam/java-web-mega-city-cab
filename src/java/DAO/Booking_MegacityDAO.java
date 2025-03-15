package DAO;

import MODEL.Booking_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Booking_MegacityDAO {
    private static final Logger logger = Logger.getLogger(Booking_MegacityDAO.class.getName());
    private Connection connection;

    public Booking_MegacityDAO(Connection connection) {
        this.connection = connection;
    }

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
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating booking", e);
            return false;
        }
    }

    public boolean updateBookingStatus(int bookingId, String status) {
        String updateSQL = "UPDATE bookings_megacity SET status = ? WHERE booking_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(updateSQL)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, bookingId);
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating booking status", e);
            return false;
        }
    }
    
    public List<Booking_Megacity> getBookingsByDriverId(int driverId) {
        List<Booking_Megacity> bookings = new ArrayList<>();
        String sql = "SELECT b.*, c.customer_name " +
                    "FROM bookings_megacity b " +
                    "JOIN customers_megacity c ON b.customer_reg_id = c.customer_reg_id " +
                    "JOIN vehicles_megacity v ON b.vehicle_id = v.vehicle_id " +
                    "WHERE v.driver_id = ?";
                    
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, driverId);
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                Booking_Megacity booking = new Booking_Megacity();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerRegId(rs.getInt("customer_reg_id"));
                booking.setVehicleId(rs.getInt("vehicle_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setPrice(rs.getDouble("price"));
                booking.setStatus(rs.getString("status"));
                
                bookings.add(booking);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving bookings for driver", e);
        }
        
        return bookings;
    }
    
    public List<Booking_Megacity> getPendingBookings() {
        List<Booking_Megacity> bookings = new ArrayList<>();
        String sql = "SELECT b.*, c.customer_name " +
                    "FROM bookings_megacity b " +
                    "JOIN customers_megacity c ON b.customer_reg_id = c.customer_reg_id " +
                    "WHERE b.status = 'pending'";
                    
        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet rs = preparedStatement.executeQuery();
            
            while (rs.next()) {
                Booking_Megacity booking = new Booking_Megacity();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerRegId(rs.getInt("customer_reg_id"));
                booking.setVehicleId(rs.getInt("vehicle_id"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDropLocation(rs.getString("drop_location"));
                booking.setBookingDate(rs.getString("booking_date"));
                booking.setBookingTime(rs.getString("booking_time"));
                booking.setPrice(rs.getDouble("price"));
                booking.setStatus(rs.getString("status"));
                
                bookings.add(booking);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving pending bookings", e);
        }
        
        return bookings;
    }
}
