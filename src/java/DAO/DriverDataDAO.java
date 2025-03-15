/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import MODEL.User_Megacity;
import MODEL.Driver_Megacity;
import MODEL.Vehicle_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Ashen Samarasekera
 */
public class DriverDataDAO {
    public List<Driver_Megacity> getDrivers() throws SQLException {
        List<Driver_Megacity> drivers = new ArrayList<>();
        String query = "SELECT * FROM megacity_database.drivers_megacity";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Driver_Megacity driver = new Driver_Megacity();
                driver.setDriverId(rs.getInt("driver_id"));
                driver.setLicenseNumber(rs.getString("license_number"));
                driver.setVehicleId(rs.getInt("vehicle_id"));
                driver.setGender(rs.getString("gender"));
                driver.setAddress(rs.getString("address"));
                driver.setVehicleType(rs.getString("vehicle_type"));
                driver.setVehicleRegistrationNumber(rs.getString("vehicle_registration_number"));
                driver.setVehicleMakeModel(rs.getString("vehicle_make_model"));
                driver.setName(rs.getString("name"));
                driver.setNic(rs.getString("nic"));
                driver.setPhoneNumber(rs.getString("phone_number"));
                
                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        
        return drivers;
    }
    

//    public List<Driver_Megacity> getAllDriversWithVehicleDetails() throws SQLException {
//        List<Driver_Megacity> drivers = new ArrayList<>();
//        String query = "SELECT d.*, v.license_plate, v.model " +
//                      "FROM megacity_database.drivers_megacity d " +
//                      "LEFT JOIN megacity_database.vehicles_megacity v ON d.vehicle_id = v.vehicle_id";
//        
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(query);
//             ResultSet rs = stmt.executeQuery()) {
//            
//            while (rs.next()) {
//                Driver_Megacity driver = new Driver_Megacity();
//                driver.setDriverId(rs.getInt("driver_id"));
//                driver.setLicenseNumber(rs.getString("license_number"));
//                driver.setVehicleId(rs.getInt("vehicle_id"));
//                driver.setGender(rs.getString("gender"));
//                driver.setAddress(rs.getString("address"));
//                driver.setVehicleType(rs.getString("vehicle_type"));
//                driver.setVehicleRegistrationNumber(rs.getString("vehicle_registration_number"));
//                driver.setVehicleMakeModel(rs.getString("vehicle_make_model"));
//                driver.setName(rs.getString("name"));
//                driver.setNic(rs.getString("nic"));
//                driver.setPhoneNumber(rs.getString("phone_number"));
//                
//                // Add vehicle details from the joined table
//                if (rs.getObject("license_plate") != null) {
//                    driver.setLicensePlate(rs.getString("license_plate"));
//                }
//                if (rs.getObject("model") != null) {
//                    driver.setModel(rs.getString("model"));
//                }
//                
//                drivers.add(driver);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            throw e;
//        }
//        
//        return drivers;
//    }
}
