/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author Ashen Samarasekera
 */

import MODEL.Booking_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DriverDashboardDAO {
    private static final Logger logger = Logger.getLogger(DriverDashboardDAO.class.getName());

    private Connection connection;

    public DriverDashboardDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to fetch all bookings
    public List<Booking_Megacity> getAllBookings() {
        List<Booking_Megacity> bookings = new ArrayList<>();
        String selectSQL = "SELECT * FROM bookings_megacity"; // Query to fetch all bookings

        try (PreparedStatement preparedStatement = connection.prepareStatement(selectSQL);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            // Iterate through the result set and create Booking_Megacity objects
            while (resultSet.next()) {
                Booking_Megacity booking = new Booking_Megacity(
                    resultSet.getInt("booking_id"),
                    resultSet.getInt("customer_reg_id"),
                    resultSet.getInt("vehicle_id"),
                    resultSet.getString("pickup_location"),
                    resultSet.getString("drop_location"),
                    resultSet.getString("booking_date"),
                    resultSet.getString("booking_time"),
                    resultSet.getDouble("price"),
                    resultSet.getString("status")
                );
                bookings.add(booking); // Add each booking to the list
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error retrieving all bookings", e);
        }

        return bookings; // Return the list of bookings
    }
}
