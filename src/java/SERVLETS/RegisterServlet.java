package SERVLETS;
import DAO.Customer_MegacityDAO;
//import DAO.Driver_MegacityDAO;
import DAO.User_MegacityDAO;
import MODEL.Customer_Megacity;
import MODEL.Driver_Megacity;
import MODEL.User_Megacity;
import java.io.IOException;
import java.net.URLEncoder;
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
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    String name = request.getParameter("name");
    String nic = request.getParameter("nic");
    String phoneNumber = request.getParameter("phone_number");

    // Create a new user with the password
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

        // Create driver object without vehicle_id
        driver = new Driver_Megacity(
            name, phoneNumber, nic, gender, address, licenseNumber, 
            vehicleType, vehicleRegistrationNumber, vehicleMakeModel
        );
    }

    // Save user along with their role-specific information
    boolean userAdded = User_MegacityDAO.addUser(user, customer, driver);

    if (userAdded) {
        HttpSession session = request.getSession();
        
           
                session.setAttribute("errorMessage", "Successfully Register.");
            // Keep the username to improve user experience
            String errorMessage = "Successfully Register.";
            response.sendRedirect("PAGES/Register.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
    } else {
        request.setAttribute("errorMessage", "Registration failed.");
        request.getRequestDispatcher("PAGES/Register.jsp").forward(request, response);
    }
}
}