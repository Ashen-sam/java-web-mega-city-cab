import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;
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
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection(); // Using existing database connection class
            
            if ("customer".equals(role)) {
                String sql = "INSERT INTO customers_megacity (name, address, nic, phone_number) VALUES (?, '', ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, nic);
                ps.setString(3, phoneNumber);
                ps.executeUpdate();
            } else if ("driver".equals(role)) {
                String sql = "INSERT INTO drivers_megacity (name, phone_number, nic, license_number, vehicle_id) VALUES (?, ?, ?, '', NULL)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, phoneNumber);
                ps.setString(3, nic);
                ps.executeUpdate();
            }

            String userSql = "INSERT INTO users_megacity (username, password, role) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(userSql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.executeUpdate();
            
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            response.sendRedirect("PAGES/Login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("../PAGES/Register.jsp");
            dispatcher.forward(request, response);
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
