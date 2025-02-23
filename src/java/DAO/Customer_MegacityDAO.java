/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import MODEL.Customer_Megacity;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
}
