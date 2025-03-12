package SERVLETS;

import DAO.User_MegacityDAO;
import MODEL.User_Megacity;

import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Fetch user from DAO
        User_Megacity user = User_MegacityDAO.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            // Redirect based on user role
            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect("PAGES/AdminDashboard.jsp");
                    break;
                case "customer":
                    response.sendRedirect("PAGES/CustomerDashboard.jsp");
                    break;
                case "driver":
                    response.sendRedirect("PAGES/DriverDashboard.jsp");
                    break;
                default:
                    response.sendRedirect("PAGES/Dashboard-booking.jsp");
                    break;
            }
        } else {
              HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Invalid username or password.");
            // Keep the username to improve user experience
            session.setAttribute("lastUsername", username);
            String errorMessage = "Invalid username or password.";
            response.sendRedirect("PAGES/Login.jsp?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
        }
    }
}
