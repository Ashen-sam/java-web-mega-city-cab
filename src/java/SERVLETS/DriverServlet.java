package SERVLETS;

import DAO.DBConnection;
import DAO.Booking_MegacityDAO;
import MODEL.Booking_Megacity;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "DriverServlet", urlPatterns = {"/DriverServlet"})
public class DriverServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer driverId = (Integer) session.getAttribute("driver_id");

        if (driverId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection connection = DBConnection.getConnection()) {
            Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);
            List<Booking_Megacity> driverBookings = bookingDAO.getBookingsForDriver(driverId);
            request.setAttribute("driverBookings", driverBookings);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("DriverBookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));

        try (Connection connection = DBConnection.getConnection()) {
            Booking_MegacityDAO bookingDAO = new Booking_MegacityDAO(connection);

            if ("approve".equals(action)) {
                bookingDAO.updateBookingStatus(bookingId, "approved");
            } else if ("reject".equals(action)) {
                bookingDAO.updateBookingStatus(bookingId, "rejected");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("DriverServlet");
    }
}
