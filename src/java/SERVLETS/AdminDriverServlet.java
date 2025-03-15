package SERVLETS;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.AdminDriverDAO;
import DAO.DBConnection;
import MODEL.Driver_Megacity;
import MODEL.User_Megacity;
import MODEL.Vehicle_Megacity;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ashen Samarasekera
 */
@WebServlet(name = "AdminDriverServlet", urlPatterns = {"/AdminDriverServlet"})
public class AdminDriverServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            AdminDriverDAO driverDAO = new AdminDriverDAO(conn);

            if (action.equals("add")) {
                // Add new driver

                // Get form data
                String name = request.getParameter("name");
                String phoneNumber = request.getParameter("phone_number");
                String nic = request.getParameter("nic");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");
                String license_plate = request.getParameter("license_plate");

                String licenseNumber = request.getParameter("license_number");
                String vehicleType = request.getParameter("vehicle_type");
                String vehicleRegistration = request.getParameter("vehicle_registration_number");
                String vehicleModel = request.getParameter("vehicle_make_model");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                //String model = request.getParameter("model");

                // Create User object
                User_Megacity user = new User_Megacity(username, password, "driver");

                // Create Driver object
                Driver_Megacity driver = new Driver_Megacity(
                        name, phoneNumber, nic, gender, address, licenseNumber,
                        vehicleType, vehicleRegistration, vehicleModel);

                // Create Vehicle object
                Vehicle_Megacity vehicle = new Vehicle_Megacity(
                        license_plate, vehicleModel, vehicleType);

                // Add driver with user and vehicle information
                driverDAO.addDriver(user, driver, vehicle);

                // Redirect to admin dashboard
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Driver Added Successfully.");
                // Keep the username to improve user experience
                String errorMessage = "Driver Added Successfully.";
                response.sendRedirect("PAGES/AdminDashboard.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));

            } else if (action.equals("update")) {
                // Update existing driver

                // Get form data
                int driverId = Integer.parseInt(request.getParameter("id"));
                int vehicleId = Integer.parseInt(request.getParameter("vehicle_id"));
                String name = request.getParameter("name");
                String phoneNumber = request.getParameter("phone_number");
                String nic = request.getParameter("nic");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");
                String licenseNumber = request.getParameter("license_number");
                String vehicleType = request.getParameter("vehicle_type");
                String vehicleRegistration = request.getParameter("vehicle_registration");
                String vehicleModel = request.getParameter("vehicle_model");

                // Create Driver object
                Driver_Megacity driver = new Driver_Megacity(
                        name, phoneNumber, nic, gender, address, licenseNumber,
                        vehicleType, vehicleRegistration, vehicleModel);
                driver.setVehicleId(vehicleId);

                // Create Vehicle object
                Vehicle_Megacity vehicle = new Vehicle_Megacity(
                        vehicleId, vehicleRegistration, vehicleModel, vehicleType);

                // Update driver and vehicle information
                driverDAO.updateDriver(driver, vehicle);

                // Redirect to admin dashboard
                response.sendRedirect(request.getContextPath() + "/ADMIN/admin-dashboard.jsp");
            } else if (action.equals("delete")) {
                // Handle delete action
                // int nicId = request.getParameter("driverID");

                // // First, we need to get the driver_id from the nic
                // int driverId = getDriverIdByNic(conn, nicId);

                String driverIdStr = request.getParameter("driverID");

                if (driverIdStr != null && !driverIdStr.isEmpty()) {
                    int driverId = Integer.parseInt(driverIdStr);
    
                    // Delete the driver using driverID
                    boolean deleted = driverDAO.deleteDriver(driverId);
                    
//                if (driverId > 0) {
//                    // Delete the driver
//                    boolean deleted = driverDAO.deleteDriver(driverId);

                    if (deleted) {
                        // Successfully deleted
                        response.sendRedirect(request.getContextPath() + "/PAGES/AdminDashboard.jsp");
                    } else {
                        // Failed to delete
                      
                                                response.sendRedirect(request.getContextPath() + "/PAGES/AdminDashboard.jsp");

                    }   
                } else {
                    // Driver not found
                    response.sendRedirect(request.getContextPath() + "/ADMIN/admin-dashboard.jsp?error=driverNotFound");
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    // Helper method to get driver_id from NIC
    private int getDriverIdByNic(Connection conn, String nic) throws SQLException {
        String sql = "SELECT driver_id FROM drivers_megacity WHERE nic = ?";
        try (java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nic);
            try (java.sql.ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("driver_id");
                }
            }
        }
        return -1; // Return -1 if not found
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For handling GET requests if needed
        response.sendRedirect(request.getContextPath() + "/ADMIN/admin-dashboard.jsp");
    }
}
