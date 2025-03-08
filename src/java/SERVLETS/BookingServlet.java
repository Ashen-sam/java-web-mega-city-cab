package SERVLETS;

import DAO.Booking_MegacityDAO;
import DAO.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private DBConnection dbDAO;

    @Override
    public void init() throws ServletException {
        dbDAO = new DBConnection(); // Initialize the DBConnection instance
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        String pickup = request.getParameter("pickupLocation");
        String drop = request.getParameter("dropLocation");
        String date = request.getParameter("bookingDate");
        String vehicleType = request.getParameter("vehicleType");
        String price = request.getParameter("price");
        String nic = request.getParameter("nic");

        try (Connection connection = dbDAO.getConnection()) {
            Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);

            int customerRegId = getCustomerRegIdByNIC(nic, connection);
            if (customerRegId == -1) {
                request.setAttribute("message", "Customer not found with this NIC.");
                request.getRequestDispatcher("PAGES/CustomerDashboard.jsp").forward(request, response);
                return;
            }

            int vehicleId = getAvailableVehicleByType(vehicleType, connection);
            if (vehicleId == -1) {
                request.setAttribute("message", "No available vehicles of this type.");
                request.getRequestDispatcher("PAGES/CustomerDashboard.jsp").forward(request, response);
                return;
            }

            boolean bookingSuccess = bookingDAO.createBooking(customerRegId, vehicleId, pickup, drop, date, "10:00:00", Double.parseDouble(price));
            if (bookingSuccess) {
                request.setAttribute("message", "Booking successful! Your fare is " + price);
            } else {
                request.setAttribute("message", "Booking failed. Please try again.");
            }

            request.getRequestDispatcher("PAGES/CustomerDashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your booking.");
            request.getRequestDispatcher("PAGES/CustomerDashboard.jsp").forward(request, response);
        }
    }

    private int getCustomerRegIdByNIC(String nic, Connection connection) throws SQLException {
        String sql = "SELECT customer_reg_id FROM customers_megacity WHERE nic = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, nic);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? rs.getInt("customer_reg_id") : -1;
            }
        }
    }

    private int getAvailableVehicleByType(String vehicleType, Connection connection) throws SQLException {
        String sql = "SELECT vehicle_id FROM vehicles_megacity WHERE vehicle_type = ? LIMIT 1";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, vehicleType);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? rs.getInt("vehicle_id") : -1;
            }
        }
    }
}