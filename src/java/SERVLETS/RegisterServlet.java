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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String name = request.getParameter("name");
        String nic = request.getParameter("nic");
        String phoneNumber = request.getParameter("phone_number");

        User_Megacity user = new User_Megacity(username, password, role);
        boolean userAdded = User_MegacityDAO.addUser(user);

        if ("customer".equals(role)) {
            Customer_Megacity customer = new Customer_Megacity(name, nic, phoneNumber);
            Customer_MegacityDAO.addCustomer(customer);
        } else if ("driver".equals(role)) {
            Driver_Megacity driver = new Driver_Megacity(name, phoneNumber, nic);
            Driver_MegacityDAO.addDriver(driver);
        }

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

}
