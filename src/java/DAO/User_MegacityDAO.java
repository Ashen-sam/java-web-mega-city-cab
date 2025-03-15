package DAO;

import MODEL.Customer_Megacity;
import MODEL.Driver_Megacity;
import MODEL.User_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class User_MegacityDAO {
public static boolean addUser(User_Megacity user, Customer_Megacity customer, Driver_Megacity driver) {
        Connection conn = null;
        PreparedStatement pstmtUser = null;
        PreparedStatement pstmtVehicle = null;
        PreparedStatement pstmtDriver = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); 

        String sqlUser = "INSERT INTO users_megacity (username, password, role) VALUES (?, ?, ?)";
        pstmtUser = conn.prepareStatement(sqlUser, PreparedStatement.RETURN_GENERATED_KEYS);
        pstmtUser.setString(1, user.getUsername());
        pstmtUser.setString(2, user.getPassword());
        pstmtUser.setString(3, user.getRole());
        pstmtUser.executeUpdate();

        int userId = -1;
        rs = pstmtUser.getGeneratedKeys();
        if (rs.next()) {
            userId = rs.getInt(1); 
        }

        if (userId == -1) {
            throw new SQLException("Failed to retrieve user_id.");
        }

        if ("customer".equalsIgnoreCase(user.getRole())) {
            String sqlCustomer = "INSERT INTO customers_megacity (name, nic, phone_number) VALUES (?, ?, ?)";
            pstmtUser = conn.prepareStatement(sqlCustomer);
            pstmtUser.setString(1, customer.getName());
            pstmtUser.setString(2, customer.getNic());
            pstmtUser.setString(3, customer.getPhoneNumber());
            pstmtUser.executeUpdate();
            } else if ("driver".equalsIgnoreCase(user.getRole())) {
                String sqlVehicle = "INSERT INTO vehicles_megacity (license_plate, model, vehicle_type) VALUES (?, ?, ?)";
                pstmtVehicle = conn.prepareStatement(sqlVehicle, PreparedStatement.RETURN_GENERATED_KEYS);
                pstmtVehicle.setString(1, driver.getVehicleRegistrationNumber());
                pstmtVehicle.setString(2, driver.getVehicleMakeModel());
                pstmtVehicle.setString(3, driver.getVehicleType());
                pstmtVehicle.executeUpdate();

                int vehicleId = -1;
                rs = pstmtVehicle.getGeneratedKeys();
                if (rs.next()) {
                    vehicleId = rs.getInt(1);
                }

                if (vehicleId == -1) {
                    throw new SQLException("Failed to retrieve vehicle_id.");
                }

                driver.setVehicleId(vehicleId);

                String sqlDriver = "INSERT INTO drivers_megacity (license_number, vehicle_id, gender, address, vehicle_type, vehicle_registration_number, vehicle_make_model, name, nic, phone_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pstmtDriver = conn.prepareStatement(sqlDriver);
                pstmtDriver.setString(1, driver.getLicenseNumber());
                pstmtDriver.setInt(2, driver.getVehicleId());
                pstmtDriver.setString(3, driver.getGender());
                pstmtDriver.setString(4, driver.getAddress());
                pstmtDriver.setString(5, driver.getVehicleType());
                pstmtDriver.setString(6, driver.getVehicleRegistrationNumber());
                pstmtDriver.setString(7, driver.getVehicleMakeModel());
                pstmtDriver.setString(8, driver.getName());
                pstmtDriver.setString(9, driver.getNic());
                pstmtDriver.setString(10, driver.getPhoneNumber());
                pstmtDriver.executeUpdate();
            }

            conn.commit(); // Commit transaction
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (pstmtUser != null) pstmtUser.close();
                if (pstmtVehicle != null) pstmtVehicle.close();
                if (pstmtDriver != null) pstmtDriver.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

        public static User_Megacity getUserByUsernameAndPassword(String username, String password) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users_megacity WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new User_Megacity(rs.getString("username"), rs.getString("password"), rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}