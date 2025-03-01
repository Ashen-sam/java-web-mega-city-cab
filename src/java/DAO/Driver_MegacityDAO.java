package DAO;

import MODEL.Driver_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class Driver_MegacityDAO {

    public static boolean addDriver(Driver_Megacity driver) {
        try (Connection conn = DBConnection.getConnection()) {
            // SQL query to insert a new driver with all fields
            String sql = "INSERT INTO drivers_megacity (name, phone_number, nic, gender, address, " +
                         "license_expiry_date, driving_experience, vehicle_type, vehicle_registration_number, " +
                         "vehicle_make_model) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            // Prepare the statement
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, driver.getName());
            ps.setString(2, driver.getPhoneNumber());
            ps.setString(3, driver.getNic());
            ps.setString(4, driver.getGender());
            ps.setString(5, driver.getAddress());
            ps.setString(6, driver.getLicenseExpiryDate());
            ps.setInt(7, driver.getDrivingExperience());
            ps.setString(8, driver.getVehicleType());
            ps.setString(9, driver.getVehicleRegistrationNumber());
            ps.setString(10, driver.getVehicleMakeModel());

            // Execute the update
            ps.executeUpdate();
            return true; // Return true if the driver is added successfully
        } catch (Exception e) {
            e.printStackTrace(); // Print the stack trace if an error occurs
            return false; // Return false if the operation fails
        }
    }
}