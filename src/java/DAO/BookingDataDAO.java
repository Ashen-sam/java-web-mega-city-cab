/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import MODEL.Booking_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author Ashen Samarasekera
 */
public class BookingDataDAO {
    public static List<Booking_Megacity> getAllBookingsData() throws SQLException, ClassNotFoundException {
        List<Booking_Megacity> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings_megacity";
        
        try (Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
               Booking_Megacity booking = new Booking_Megacity();
               booking.setBookingId(rs.getInt("booking_id"));
               booking.setCustomerRegId(rs.getInt("customer_reg_id"));
//               booking.setDriverId(rs.getInt("driver_id"));
               booking.setVehicleId(rs.getInt("vehicle_id"));
               booking.setPickupLocation(rs.getString("pickup_location"));
               booking.setDropLocation(rs.getString("drop_location"));
               booking.setBookingDate(rs.getString("booking_date"));
               booking.setPrice(rs.getDouble("price"));
               booking.setStatus(rs.getString("status"));
                
               bookings.add(booking);
           }
       }
       return bookings;
    }
    
    
    /**
     * Update booking status (Accept or Reject)
     * @param bookingId The booking ID
     * @param status The new status (ACCEPTED or REJECTED)
     * @return true if successful, false otherwise
     */
  // Inside BookingDataDAO.java
public static boolean updateBookingStatus(int bookingId, String status) throws SQLException {
    Connection con = null;
    PreparedStatement pst = null;
    boolean result = false;
    
    try {
        con = DBConnection.getConnection();
        String sql = "UPDATE bookings_megacity SET status = ? WHERE booking_id = ?";
        pst = con.prepareStatement(sql);
        pst.setString(1, status);
        pst.setInt(2, bookingId);
        
        int rowsAffected = pst.executeUpdate();
        result = (rowsAffected > 0);
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
    
    return result;
}
    
    /**
     * Delete a booking from the database
     * @param bookingId The booking ID to delete
     * @return true if successful, false otherwise
     */
    public static boolean deleteBooking(int bookingId) throws SQLException, ClassNotFoundException {
        String query = "DELETE FROM bookings_megacity WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
//            LOGGER.log(Level.SEVERE, "Error deleting booking", e);
            throw e;
        }
    }
}
