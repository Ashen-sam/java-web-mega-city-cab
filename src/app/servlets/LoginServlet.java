import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/action")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate user credentials
        boolean isValidUser = validateUser(username, password);

        if (isValidUser) {
            // Create a session and redirect to the dashboard
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("dashboard.jsp"); // Redirect to a dashboard page
        } else {
            // Invalid credentials, redirect back to login with an error message
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private boolean validateUser(String username, String password) {
        boolean isValid = false;
        try {
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/megacity_database"; // Adjust as needed
            String dbUsername = "root"; // Your database username
            String dbPassword = "password"; // Your database password

            Connection connection = DriverManager.getConnection(url, dbUsername, dbPassword);
            String sql = "SELECT * FROM users_megacity WHERE username = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            ResultSet resultSet = statement.executeQuery();
            isValid = resultSet.next(); // Returns true if user exists

            connection.close(); // Close the connection
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }
}
