<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DAO.DBConnection"%>
<%@page import="MODEL.Booking_Megacity"%>
<%@page import="DAO.DriverDashboardDAO"%> 
<%@page import="MODEL.Booking_Megacity"%>
<%@page import="DAO.BookingDataDAO"%>
<%@ page import="DAO.DriverDashboardDAO" %>
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
        <style>
            .driver-assigned {
                background-color: #f0fff0;
                font-weight: bold;
            }

            .booking-table td {
                padding: 12px 8px;
            }

            .driver-name-cell {
                font-weight: 500;
                color: #333;
            }

            .not-assigned {
                color: #888;
                font-style: italic;
            }

            .action-btn.approve-btn {
                background-color: #4CAF50;
                color: white;
            }

            .action-btn.cancel-btn {
                background-color: #f44336;
                color: white;
            }

            .action-buttons {
                display: flex;
                gap: 5px;
            }
            .status-badge.approved {
                background-color: #4CAF50;
                color: white;
            }

            .status-badge.rejected {
                background-color: #f44336;
                color: white;
            }
        </style>
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

            // Get driver ID from session
            Integer driverId = (Integer) session.getAttribute("driverId");
        %>
        <div class="driver-container">
            <div class="driver-header">
                <div class="driver-logo">
                    <i class="fas fa-taxi" style="font-size: 24px;"></i>
                    <h3>MegaCab Driver</h3>
                </div>
                <div class="driver-actions">
                    <button class="driver-btn" style="display: flex;justify-content: center;align-items:center;gap:10px">
                        <i class="fa-solid fa-user"></i>
                        <p><%= username%></p>
                    </button>
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

                    <!-- Display messages if any -->
                    <% if (session.getAttribute("message") != null) {%>
                    <div class="message-box success-message">
                        <i class="fas fa-check-circle"></i> <%= session.getAttribute("message")%>
                        <% session.removeAttribute("message"); %>
                    </div>
                    <% } %>

                    <% if (session.getAttribute("error") != null) {%>
                    <div class="message-box error-message">
                        <i class="fas fa-exclamation-circle"></i> <%= session.getAttribute("error")%>
                        <% session.removeAttribute("error"); %>
                    </div>
                    <% } %>

                    <table class="booking-table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Customer</th>
                                <th>Pickup Location</th>
                                <th>Destination</th>
                                <th>Date</th>
                                <th>Fare</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    List<Booking_Megacity> bookings = BookingDataDAO.getAllBookingsData();
                                    for (Booking_Megacity booking : bookings) {
                                        String status = booking.getStatus().toLowerCase();
                            %>
                            <tr>
                                <td>#<%= booking.getBookingId()%></td>
                                <td><%= booking.getCustomerName() != null ? booking.getCustomerName() : "Customer #" + booking.getCustomerRegId()%></td>
                                <td><%= booking.getPickupLocation()%></td>
                                <td><%= booking.getDropLocation()%></td>
                                <td><%= booking.getBookingDate()%></td>
                                <td>Rs <%= String.format("%.2f", booking.getPrice())%></td>
                                <td><span class="status-badge <%= status%>"><%= booking.getStatus()%></span></td>
                                <td class="action-buttons">
                                    <form action="<%=request.getContextPath()%>/BookingActionServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="approve">
                                        <input type="hidden" name="bookingId" value="<%= booking.getBookingId()%>">
                                        <button style="padding:1rem" type="submit" class="action-btn approve-btn" title="Approve Booking">
                                            <i class="fas fa-check"></i>
                                        </button>
                                    </form>

                                    <form action="<%=request.getContextPath()%>/BookingActionServlet" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="bookingId" value="<%= booking.getBookingId()%>">
                                        <button style="padding:1rem" type="submit" class="action-btn cancel-btn" title="Cancel Booking">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </form>


                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script>
            // Add any JavaScript functionality here
            document.addEventListener('DOMContentLoaded', function () {
                // Auto-dismiss messages after 5 seconds
                setTimeout(function () {
                    const messages = document.querySelectorAll('.message-box');
                    messages.forEach(function (message) {
                        message.style.display = 'none';
                    });
                }, 5000);
            });
        </script>
    </body>
</html>