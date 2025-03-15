package SERVLETS;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DriverDashboardServlet", urlPatterns = {"/DriverDashboardServlet"})
public class DriverDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in and is a driver
        String username = (String) session.getAttribute("username");
        Integer driverId = (Integer) session.getAttribute("driverId");
        
        if (username == null || driverId == null) {
            // Redirect to login page if not logged in
            response.sendRedirect(request.getContextPath() + "/PAGES/Login.jsp");
            return;
        }
        
        // Process view mode parameter (if any)
        String viewMode = request.getParameter("viewMode");
        
        // Forward to the driver dashboard JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/PAGES/DriverDashboard.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}