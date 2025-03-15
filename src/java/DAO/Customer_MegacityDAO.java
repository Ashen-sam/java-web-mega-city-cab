/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import MODEL.Booking_Megacity;
import MODEL.Customer_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
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
public class Customer_MegacityDAO {
    private static List<Customer_Megacity> customers = new ArrayList<>();

    public static boolean addCustomer(Customer_Megacity customer) {
        customers.add(customer);
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO customers_megacity (name, address, nic, phone_number) VALUES (?, '', ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getNic());
            ps.setString(3, customer.getPhoneNumber());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static List<Booking_Megacity> getApprovedBookingsForCustomer(String username) throws SQLException, ClassNotFoundException {
        List<Booking_Megacity> approvedBookings = new ArrayList<>();
        String query = "SELECT b.* FROM bookings_megacity b " +
                       "JOIN customers_megacity c ON b.customer_reg_id = c.customer_reg_id " +
                       "WHERE c.name = ? AND b.status = 'Approved'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Booking_Megacity booking = new Booking_Megacity();
                    booking.setBookingId(rs.getInt("booking_id"));
                    booking.setCustomerRegId(rs.getInt("customer_reg_id"));
                    booking.setVehicleId(rs.getInt("vehicle_id"));
                    booking.setPickupLocation(rs.getString("pickup_location"));
                    booking.setDropLocation(rs.getString("drop_location"));
                    booking.setBookingDate(rs.getString("booking_date"));
                    booking.setPrice(rs.getDouble("price"));
                    booking.setStatus(rs.getString("status"));
                    
                    approvedBookings.add(booking);
                }
            }
        }
        
        return approvedBookings;
    }
}

