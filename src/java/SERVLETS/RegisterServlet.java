package SERVLETS;

import DAO.Customer_MegacityDAO;
import DAO.Driver_MegacityDAO;
import DAO.User_MegacityDAO;
import MODEL.Customer_Megacity;
import MODEL.Driver_Megacity;
import MODEL.User_Megacity;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String nic = request.getParameter("nic");
        String phoneNumber = request.getParameter("phone_number");

        // Hash the password
//        String hashedPassword = hashPassword(password);

        // Create a new user with the hashed password
        User_Megacity user = new User_Megacity(username, password, role);
        Customer_Megacity customer = null;
        Driver_Megacity driver = null;

        if ("customer".equalsIgnoreCase(role)) {
            customer = new Customer_Megacity(name, nic, phoneNumber);
        } else if ("driver".equalsIgnoreCase(role)) {
            // Retrieve additional driver-specific fields
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String licenseNumber = request.getParameter("license_number");
            String vehicleType = request.getParameter("vehicle_type");
            String vehicleRegistrationNumber = request.getParameter("vehicle_registration_number");
            String vehicleMakeModel = request.getParameter("vehicle_make_model");

            driver = new Driver_Megacity(
                name, phoneNumber, nic, gender, address, licenseNumber, 
                vehicleType, vehicleRegistrationNumber, vehicleMakeModel
            );
        }

        // Save user along with their role-specific information
        boolean userAdded = User_MegacityDAO.addUser(user, customer, driver);

        if (userAdded) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            response.sendRedirect("PAGES/Login.jsp");
        } else {
            request.setAttribute("errorMessage", "Registration failed.");
            request.getRequestDispatcher("PAGES/Register.jsp").forward(request, response);
        }
    }

    // Method to hash the password using SHA-256
//    private String hashPassword(String password) {
//        try {
//            MessageDigest digest = MessageDigest.getInstance("SHA-256");
//            byte[] hashBytes = digest.digest(password.getBytes());
//            StringBuilder hexString = new StringBuilder();
//
//            for (byte b : hashBytes) {
//                String hex = Integer.toHexString(0xff & b);
//                if (hex.length() == 1) hexString.append('0');
//                hexString.append(hex);
//            }
//
//            return hexString.toString();
//        } catch (NoSuchAlgorithmException e) {
//            throw new RuntimeException("Failed to hash password.", e);
//        }
//    }
}
