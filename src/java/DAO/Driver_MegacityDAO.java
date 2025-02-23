/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import MODEL.Driver_Megacity;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
/**
 *
 * @author Ashen Samarasekera
 */
public class Driver_MegacityDAO {
     private static List<Driver_Megacity> drivers = new ArrayList<>();

    public static boolean addDriver(Driver_Megacity driver) {
        drivers.add(driver);
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO drivers_megacity (name, phone_number, nic, license_number, vehicle_id) VALUES (?, ?, ?, '', NULL)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, driver.getName());
            ps.setString(2, driver.getPhoneNumber());
            ps.setString(3, driver.getNic());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
