<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DAO.DBConnection"%>
<%@page import="MODEL.Booking_Megacity"%>
<%@page import="DAO.Booking_MegacityDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="stylesheet" href="../STYLES/driver-styles.css" />
        <title>Driver Dashboard - MegaCab</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

    </head>
    <body>
        <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            if (username == null) {
                // Redirect to login page if not logged in
                response.sendRedirect(request.getContextPath() + "/PAGES/Login.jsp");
                return;
            }
        %>
        <div class="driver-container">
            <div class="driver-header">
                <div class="driver-logo">
                    <i class="fas fa-taxi" style="font-size: 24px;"></i>
                    <h3>MegaCab Driver</h3>
                </div>
                <div class="driver-actions">
                    <Button class="driver-btn " style="display: flex;justify-content: center;align-items:center;gap:10px">
                        <i class="fa-solid fa-user"></i>
                        <p><%= username%></p>

                    </Button>
                    <form action="<%=request.getContextPath()%>/LogoutServlet" method="post" style="display: inline;">
                        <button type="submit" class="driver-btn">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </button>
                    </form>
                </div>
            </div>

            <div class="driver">

                <div class="driver-content">
                    <div class="content-header">
                        <h2 class="content-title">Booking Orders</h2>
                    </div>

                    <!-- Booking Orders Table -->
                    <table class="booking-table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer</th>
                                <th>Pickup Location</th>
                                <th>Destination</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Fare</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Connection conn = DBConnection.getConnection();

                                    // First, let's join with customers_megacity to get customer names
                                    String sql = "SELECT b.booking_id, c.customer_name, b.pickup_location, b.drop_location, "
                                            + "b.booking_date, b.booking_time, b.price, b.status, v.vehicle_id "
                                            + "FROM bookings_megacity b "
                                            + "JOIN customers_megacity c ON b.customer_reg_id = c.customer_reg_id "
                                            + "JOIN vehicles_megacity v ON b.vehicle_id = v.vehicle_id "
                                            + "WHERE b.status = 'pending' OR (b.status IN ('approved') AND v.driver_id = ?)";

                                    PreparedStatement ps = conn.prepareStatement(sql);

                                    // Assuming you have the driverId stored in session
                                    int driverId = 1; // Default value for testing
                                    if (session.getAttribute("driverId") != null) {
                                        driverId = (Integer) session.getAttribute("driverId");
                                    }
                                    ps.setInt(1, driverId);

                                    ResultSet rs = ps.executeQuery();
                                    while (rs.next()) {
                                        String status = rs.getString("status");
                            %>
                            <tr>
                                <td><%= rs.getInt("booking_id")%></td>
                                <td><%= rs.getString("customer_name")%></td>
                                <td><%= rs.getString("pickup_location")%></td>
                                <td><%= rs.getString("drop_location")%></td>
                                <td><%= rs.getDate("booking_date")%></td>
                                <td><%= rs.getTime("booking_time")%></td>
                                <td>$<%= String.format("%.2f", rs.getDouble("price"))%></td>
                                <td>
                                    <% if (status.equals("pending")) { %>
                                    <span class="status-pending">Pending</span>
                                    <% } else if (status.equals("approved")) { %>
                                    <span class="status-approved">Approved</span>
                                    <% } else if (status.equals("rejected")) { %>
                                    <span class="status-rejected">Rejected</span>
                                    <% } %>
                                </td>
                                <td>
                                    <% if (status.equals("pending")) {%>
                                    <div class="action-buttons">
                                        <form action="BookingServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id")%>">
                                            <button type="submit" class="accept-btn">
                                                <i class="fas fa-check"></i> Accept
                                            </button>
                                        </form>
                                        <form action="BookingServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="reject">
                                            <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id")%>">
                                            <button type="submit" class="reject-btn">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </form>
                                    </div>
                                    <% } else if (status.equals("approved")) {%>
                                    <form action="BookingServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="complete">
                                        <input type="hidden" name="bookingId" value="<%= rs.getInt("booking_id")%>">
                                        <button type="submit" class="accept-btn">
                                            <i class="fas fa-check-circle"></i> Complete Ride
                                        </button>
                                    </form>
                                    <% } %>
                                </td>
                            </tr>
                            <%
                                    }
                                    rs.close();
                                    ps.close();
                                    conn.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            // You can add JavaScript functionality here if needed
            document.addEventListener('DOMContentLoaded', function () {
                // This would typically come from your session or an API call
                const driverName = "<%= session.getAttribute("driverName") != null ? session.getAttribute("driverName") : "John Doe"%>";
                if (driverName) {
                    document.getElementById('driver-name').textContent = driverName;
                }
            });
        </script>
    </body>
</html>