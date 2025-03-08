package DAO;

import MODEL.User_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import MODEL.Driver_Megacity;
import MODEL.Customer_Megacity;
import java.sql.SQLException;

public class User_MegacityDAO {

    public static boolean addUser(User_Megacity user, Customer_Megacity customer, Driver_Megacity driver) {
        Connection conn = null;
        PreparedStatement userPs = null, customerPs = null, driverPs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.out.println("Failed to establish connection.");
                return false;
            }
            conn.setAutoCommit(false); // Start transaction

            // Step 1: Insert into users_megacity table and get the generated user_id
            String userSql = "INSERT INTO users_megacity (username, password, role) VALUES (?, ?, ?)";
            userPs = conn.prepareStatement(userSql, PreparedStatement.RETURN_GENERATED_KEYS);
            userPs.setString(1, user.getUsername());
            userPs.setString(2, user.getPassword());
            userPs.setString(3, user.getRole());
            int affectedRows = userPs.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Inserting user failed, no rows affected.");
            }

            int userId = -1;
            try (ResultSet generatedKeys = userPs.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    userId = generatedKeys.getInt(1); // Get the auto-incremented user_id
                } else {
                    throw new SQLException("User insertion failed, no ID obtained.");
                }
            }

            // Step 2: Insert into customers_megacity if the user is a customer
            if ("customer".equalsIgnoreCase(user.getRole()) && customer != null) {
                String customerSql = "INSERT INTO customers_megacity (customer_reg_id, name, nic, phone_number) VALUES (?, ?, ?, ?)";
                customerPs = conn.prepareStatement(customerSql);
                customerPs.setInt(1, userId); // Use the generated userId here
                customerPs.setString(2, customer.getName());
                customerPs.setString(3, customer.getNic());
                customerPs.setString(4, customer.getPhoneNumber());
                customerPs.executeUpdate();
            }

            // Step 3: Insert into drivers_megacity if the user is a driver
            else if ("driver".equalsIgnoreCase(user.getRole()) && driver != null) {
                String driverSql = "INSERT INTO drivers_megacity (driver_id, name, phone_number, nic, gender, address, license_number, vehicle_type, vehicle_registration_number, vehicle_make_model) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                driverPs = conn.prepareStatement(driverSql);
                driverPs.setInt(1, userId); // Use the generated userId here as the driver_id
                driverPs.setString(2, driver.getName());
                driverPs.setString(3, driver.getPhoneNumber());
                driverPs.setString(4, driver.getNic());
                driverPs.setString(5, driver.getGender());
                driverPs.setString(6, driver.getAddress()); // Ensure address is set
                driverPs.setString(7, driver.getLicenseNumber());
                driverPs.setString(8, driver.getVehicleType());
                driverPs.setString(9, driver.getVehicleRegistrationNumber());
                driverPs.setString(10, driver.getVehicleMakeModel());
                driverPs.executeUpdate();
            }

            conn.commit(); // Commit transaction
            return true;

        } catch (SQLException e) {
            System.out.println("SQL Error during addUser: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback in case of error
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } catch (Exception e) {
            System.out.println("Error during addUser: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (userPs != null) userPs.close();
                if (customerPs != null) customerPs.close();
                if (driverPs != null) driverPs.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset auto-commit
                }
            } catch (Exception closeEx) {
                closeEx.printStackTrace();
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