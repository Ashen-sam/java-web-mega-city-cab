package DAO;

import MODEL.Driver_Megacity;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriverDashboardDAO {
    
    // Get driver name by driver ID
    public String getDriverNameById(int driverId) {
        String driverName = "Unknown Driver";
        String sql = "SELECT driver_name FROM drivers WHERE driver_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, driverId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    driverName = rs.getString("driver_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return driverName;
    }
    
    // Check if a driver is assigned to a booking
    public boolean isDriverAssignedToBooking(int bookingId, int driverId) {
        String sql = "SELECT COUNT(*) FROM bookings_megacity b " +
                     "JOIN vehicles v ON b.vehicle_id = v.vehicle_id " +
                     "WHERE b.booking_id = ? AND v.driver_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingId);
            stmt.setInt(2, driverId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
             public List<Driver_Megacity> getAllDrivers() throws SQLException {
        List<Driver_Megacity> drivers = new ArrayList<>();
        String sql = "SELECT d.*, v.license_plate, v.model FROM drivers_megacity d " +
                "LEFT JOIN vehicles_megacity v ON d.vehicle_id = v.vehicle_id";
        
        try (Connection conn = DBConnection.getConnection();
              PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Driver_Megacity driver = new Driver_Megacity(
                    rs.getString("name"),
                    rs.getString("phone_number"),
                    rs.getString("nic"),
                    rs.getString("gender"),
                    rs.getString("address"),
                    rs.getString("license_number"),
                    rs.getString("vehicle_type"),
                    rs.getString("vehicle_registration_number"),
                    rs.getString("vehicle_make_model"),
                    rs.getInt("driver_id")
                );
                // Set vehicle ID manually
                driver.setVehicleId(rs.getInt("vehicle_id"));
                drivers.add(driver);
            }
        }
        
        return drivers;
    }
}