package DAO;

import MODEL.Driver_Megacity;
import MODEL.User_Megacity;
import MODEL.Vehicle_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Data Access Object for driver management in Admin Dashboard
 */
public class AdminDriverDAO {

    private Connection connection;

    public AdminDriverDAO(Connection connection) {
        this.connection = connection;
    }

    /**
     * Add a new driver with user account and vehicle information
     */
    public boolean addDriver(User_Megacity user, Driver_Megacity driver, Vehicle_Megacity vehicle) throws SQLException {
        // Insert the user first to get the user ID
        String userSql = "INSERT INTO users_megacity (username, password, role) VALUES (?, ?, ?)";
        PreparedStatement userStmt = null;

        // Insert the vehicle next to get the vehicle ID
        String vehicleSql = "INSERT INTO vehicles_megacity (license_plate, model, vehicle_type) VALUES (?, ?, ?)";
        PreparedStatement vehicleStmt = null;

        // Finally insert the driver with references to user and vehicle
        // String driverSql = "INSERT INTO drivers_megacity (license_number,vehicle_id,gender,address,vehicle_type,vehicle_registration_number,vehicle_make_model,name,nic, phone_number) "
        //         + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,)";
        String driverSql = "INSERT INTO drivers_megacity (name, phone_number, nic, gender, address, license_number, vehicle_type, vehicle_registration_number, vehicle_make_model,vehicle_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement driverStmt = null;

        try {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert user
            userStmt = connection.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, user.getUsername());
            userStmt.setString(2, user.getPassword());
            userStmt.setString(3, user.getRole());
            userStmt.executeUpdate();

            // Get generated user ID
            ResultSet userKeys = userStmt.getGeneratedKeys();
            int userId = 0;
            if (userKeys.next()) {
                userId = userKeys.getInt(1);
                user.setuserID(userId);
            } else {
                throw new SQLException("Creating user failed, no ID obtained.");
            }

            // Insert vehicle
            vehicleStmt = connection.prepareStatement(vehicleSql, Statement.RETURN_GENERATED_KEYS);
            vehicleStmt.setString(1, vehicle.getLicensePlate());
            vehicleStmt.setString(2, vehicle.getModel());
            vehicleStmt.setString(3, vehicle.getVehicleType());
            vehicleStmt.executeUpdate();

            // Get generated vehicle ID
            ResultSet vehicleKeys = vehicleStmt.getGeneratedKeys();
            int vehicleId = 0;
            if (vehicleKeys.next()) {
                vehicleId = vehicleKeys.getInt(1);
                vehicle.setVehicleId(vehicleId);
                driver.setVehicleId(vehicleId);
            } else {
                throw new SQLException("Creating vehicle failed, no ID obtained.");
            }

            // Insert driver
            driverStmt = connection.prepareStatement(driverSql);
            driverStmt.setString(1, driver.getName());
            driverStmt.setString(2, driver.getPhoneNumber());
            driverStmt.setString(3, driver.getNic());
            driverStmt.setString(4, driver.getGender());
            driverStmt.setString(5, driver.getAddress());
            driverStmt.setString(6, driver.getLicenseNumber());
            driverStmt.setString(7, driver.getVehicleType());
            driverStmt.setString(8, driver.getVehicleRegistrationNumber());
            driverStmt.setString(9, driver.getVehicleMakeModel());
            driverStmt.setInt(10, vehicleId);
        
            driverStmt.executeUpdate();

            // Commit transaction
            connection.commit();
            return true;

        } catch (SQLException e) {
            // Rollback transaction on error
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    throw ex;
                }
            }
            throw e;
        } finally {
            // Restore auto-commit mode
            if (connection != null) {
                connection.setAutoCommit(true);
            }

            // Close resources
            if (userStmt != null) {
                userStmt.close();
            }
            if (vehicleStmt != null) {
                vehicleStmt.close();
            }
            if (driverStmt != null) {
                driverStmt.close();
            }
        }
    }

    /**
     * Update an existing driver's information
     */
    public boolean updateDriver(Driver_Megacity driver, Vehicle_Megacity vehicle) throws SQLException {
        String driverSql = "UPDATE drivers_megacity SET name=?, phone_number=?, nic=?, gender=?, "
                + "address=?, license_number=?, vehicle_type=?, vehicle_registration_number=?, "
                + "vehicle_make_model=? WHERE vehicle_id=?";

        String vehicleSql = "UPDATE vehicles_megacity SET license_plate=?, model=?, vehicle_type=? "
                + "WHERE vehicle_id=?";

        PreparedStatement driverStmt = null;
        PreparedStatement vehicleStmt = null;

        try {
            // Start transaction
            connection.setAutoCommit(false);

            // Update vehicle information
            vehicleStmt = connection.prepareStatement(vehicleSql);
            vehicleStmt.setString(1, vehicle.getLicensePlate());
            vehicleStmt.setString(2, vehicle.getModel());
            vehicleStmt.setString(3, vehicle.getVehicleType());
            vehicleStmt.setInt(4, vehicle.getVehicleId());
            vehicleStmt.executeUpdate();

            // Update driver information
            driverStmt = connection.prepareStatement(driverSql);
            driverStmt.setString(1, driver.getName());
            driverStmt.setString(2, driver.getPhoneNumber());
            driverStmt.setString(3, driver.getNic());
            driverStmt.setString(4, driver.getGender());
            driverStmt.setString(5, driver.getAddress());
            driverStmt.setString(6, driver.getLicenseNumber());
            driverStmt.setString(7, driver.getVehicleType());
            driverStmt.setString(8, driver.getVehicleRegistrationNumber());
            driverStmt.setString(9, driver.getVehicleMakeModel());
            driverStmt.setInt(10, driver.getVehicleId());
            driverStmt.executeUpdate();

            // Commit transaction
            connection.commit();
            return true;

        } catch (SQLException e) {
            // Rollback transaction on error
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    throw ex;
                }
            }
            throw e;
        } finally {
            // Restore auto-commit mode
            if (connection != null) {
                connection.setAutoCommit(true);
            }

            // Close resources
            if (vehicleStmt != null) {
                vehicleStmt.close();
            }
            if (driverStmt != null) {
                driverStmt.close();
            }
        }
    }

    /**
     * Delete a driver and associated vehicle and user records
     */
    public boolean deleteDriver(int driverId) throws SQLException {
    String deleteDriverSql = "DELETE FROM drivers_megacity WHERE driver_id = ?";
    
    try (PreparedStatement deleteDriverStmt = connection.prepareStatement(deleteDriverSql)) {
        // Set parameter
        deleteDriverStmt.setInt(1, driverId);
        
        // Execute update and check if a row was deleted
        int rowsAffected = deleteDriverStmt.executeUpdate();
        
        return rowsAffected > 0;  // Return true if deletion was successful
    } catch (SQLException e) {
        System.err.println("Cannot delete driver: Foreign key constraint violation.");
        return false;  // Indicate that deletion failed due to FK constraint
    }
}

//    public boolean deleteDriver(int driverId) throws SQLException {
//        //String getUserIdSql = "SELECT vehicle_id FROM drivers_megacity WHERE driver_id = ?";
//        String deleteDriverSql = "DELETE FROM drivers_megacity WHERE driver_id = ?";
//        //String deleteVehicleSql = "DELETE FROM vehicles_megacity WHERE vehicle_id = ?";
//        //String deleteUserSql = "DELETE FROM users_megacity WHERE user_id = ?";
//
//        PreparedStatement getUserStmt = null;
//        PreparedStatement deleteDriverStmt = null;
//        PreparedStatement deleteVehicleStmt = null;
//        PreparedStatement deleteUserStmt = null;
//
//        try {
//            // Start transaction
//            connection.setAutoCommit(false);
//
//            // Get user_id and vehicle_id associated with this driver
//            //getUserStmt = connection.prepareStatement(getUserIdSql);
//            //getUserStmt.setInt(1, driverId);
//            ResultSet rs = getUserStmt.executeQuery();
//
//            if (rs.next()) {
//                //int userId = rs.getInt("user_id");
//                //int vehicleId = rs.getInt("vehicle_id");
//
//                // Delete driver record
//                deleteDriverStmt = connection.prepareStatement(deleteDriverSql);
//                deleteDriverStmt.setInt(1, driverId);
//                deleteDriverStmt.executeUpdate();
//
//                // Delete vehicle record
////                deleteVehicleStmt = connection.prepareStatement(deleteVehicleSql);
////                deleteVehicleStmt.setInt(1, vehicleId);
////                deleteVehicleStmt.executeUpdate();
//
//                // Delete user record
////                deleteUserStmt = connection.prepareStatement(deleteUserSql);
////                deleteUserStmt.setInt(1, userId);
////                deleteUserStmt.executeUpdate();
//            }
//
//            // Commit transaction
//            connection.commit();
//            return true;
//
//        } catch (SQLException e) {
//            // Rollback transaction on error
//            if (connection != null) {
//                try {
//                    connection.rollback();
//                } catch (SQLException ex) {
//                    throw ex;
//                }
//            }
//            throw e;
//        } finally {
//            // Restore auto-commit mode
//            if (connection != null) {
//                connection.setAutoCommit(true);
//            }
//
//            // Close resources
//            if (getUserStmt != null) {
//                getUserStmt.close();
//            }
//            if (deleteDriverStmt != null) {
//                deleteDriverStmt.close();
//            }
//            if (deleteVehicleStmt != null) {
//                deleteVehicleStmt.close();
//            }
//            if (deleteUserStmt != null) {
//                deleteUserStmt.close();
//            }
//        }
//    }

    public boolean updateDriverWithCredentials(Driver_Megacity driver, Vehicle_Megacity vehicle) throws SQLException {
    boolean success = false;
    connection.setAutoCommit(false);
    
    try {
        // Update vehicle information
        String vehicleSql = "UPDATE vehicles_megacity SET license_plate = ?, model = ?, type = ? WHERE vehicle_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(vehicleSql)) {
            stmt.setString(1, vehicle.getLicensePlate());
            stmt.setString(2, vehicle.getModel());
            stmt.setString(3, vehicle.getVehicleType());
            stmt.setInt(4, vehicle.getVehicleId());
            stmt.executeUpdate();
        }
        
        // Update driver information
        String driverSql = "UPDATE drivers_megacity SET name = ?, phone_number = ?, nic = ?, gender = ?, " +
                "address = ?, license_number = ?, vehicle_type = ?, vehicle_registration_number = ?, " +
                "vehicle_make_model = ? WHERE driver_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(driverSql)) {
            stmt.setString(1, driver.getName());
            stmt.setString(2, driver.getPhoneNumber());
            stmt.setString(3, driver.getNic());
            stmt.setString(4, driver.getGender());
            stmt.setString(5, driver.getAddress());
            stmt.setString(6, driver.getLicenseNumber());
            stmt.setString(7, driver.getVehicleType());
            stmt.setString(8, driver.getVehicleRegistrationNumber());
            stmt.setString(9, driver.getVehicleMakeModel());
            stmt.setInt(10, driver.getDriverId());
            stmt.executeUpdate();
        }
        
        // Get user_id for this driver
        int userId;
        String userIdSql = "SELECT user_id FROM drivers_megacity WHERE driver_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(userIdSql)) {
            stmt.setInt(1, driver.getDriverId());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getInt("user_id");
                    
                    // Update user credentials
                    String userSql = "UPDATE users_megacity SET username = ?, password = ? WHERE user_id = ?";
                    try (PreparedStatement userStmt = connection.prepareStatement(userSql)) {
                        userStmt.setString(1, driver.getUsername());
                        userStmt.setString(2, driver.getPassword());
                        userStmt.setInt(3, userId);
                        userStmt.executeUpdate();
                    }
                }
            }
        }
        
        connection.commit();
        success = true;
    } catch (SQLException e) {
        connection.rollback();
        throw e;
    } finally {
        connection.setAutoCommit(true);
    }
    
    return success;
}

    /**
     * Get a specific driver by ID
     */
    // New method to update a driver
    public boolean updateDriver(Driver_Megacity driver) throws SQLException {
        String sql = "UPDATE drivers_megacity SET name=?, phone_number=?, nic=?, gender=?, " +
                     "address=?, license_number=?, vehicle_type=?, vehicle_registration_number=?, " +
                     "vehicle_make_model=? WHERE driver_id=?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Set parameters for the driver information
            stmt.setString(1, driver.getName());
            stmt.setString(2, driver.getPhoneNumber());
            stmt.setString(3, driver.getNic());
            stmt.setString(4, driver.getGender());
            stmt.setString(5, driver.getAddress());
            stmt.setString(6, driver.getLicenseNumber());
            stmt.setString(7, driver.getVehicleType());
            stmt.setString(8, driver.getVehicleRegistrationNumber());
            stmt.setString(9, driver.getVehicleMakeModel());
            stmt.setInt(10, driver.getDriverId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    

//    // Method to get a driver by ID (useful for pre-populating edit form)
    public Driver_Megacity getDriverById(int driverId) throws SQLException {
        String sql = "SELECT * FROM drivers_megacity WHERE driver_id = ?";
       
         try(PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, driverId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Driver_Megacity(
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
                }
            }
        }
        
        return null;
    }

}
