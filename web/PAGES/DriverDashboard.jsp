<%@page import="MODEL.Booking_Megacity"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Driver Dashboard</title>
        <style>
            /* Root Styles */
            :root {
                font-family: "Poppins", serif;
            }
            
            /* Body Styling */
            body {
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
                font-family: "Poppins", serif;
            }

            h2 {
                text-align: center;
                margin: 20px 0;
                color: #3D3D3D;
            }

            /* Table Styling */
            table {
                width: 80%;
                margin: 0 auto;
                border-collapse: collapse;
                background-color: white;
                border-radius: 8px;
                box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;
            }

            th, td {
                padding: 12px 18px;
                text-align: center;
                border-bottom: 1px solid #ddd;
                font-size: 0.9rem;
            }

            th {
                background-color: #3D3D3D;
                color: white;
                font-weight: bold;
            }

            td {
                background-color: #f9f9f9;
            }

            /* Hover effect for rows */
            tr:hover {
                background-color: #f1f1f1;
            }

            /* Styling when no bookings */
            .no-bookings {
                text-align: center;
                font-size: 1rem;
                color: #ff4747;
                padding: 15px 0;
            }

            /* Additional Styling for Container */
            .table-container {
                width: 90%;
                margin: 40px auto;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;
            }

        </style>
    </head>
    <body>
        <div class="table-container">
            <h2>Driver Bookings</h2>
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer ID</th>
                        <th>Pickup</th>
                        <th>Drop</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Booking_Megacity> driverBookings = (List<Booking_Megacity>) request.getAttribute("driverBookings");
                        if (driverBookings != null && !driverBookings.isEmpty()) {
                            for (Booking_Megacity booking : driverBookings) {
                    %>
                    <tr>
                        <td><%= booking.getBookingId() %></td>
                        <td><%= booking.getCustomerRegId() %></td>
                        <td><%= booking.getPickupLocation() %></td>
                        <td><%= booking.getDropLocation() %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td><%= booking.getBookingTime() %></td>
                        <td><%= booking.getPrice() %></td>
                        <td><%= booking.getStatus() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8" class="no-bookings">No bookings assigned</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </body>
</html>
