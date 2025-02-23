<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DAO.DBConnection"%>
<%@page import="MODEL.Driver_Megacity"%>
<%@page import="DAO.Driver_MegacityDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN - Mega City Cab</title>
             <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
    </head>
    <body>
      

        <!-- Driver Registration Form -->
        <div class="">
            <h2>Add New Driver</h2>
            <form action="DriverServlet" method="post">
                <input type="hidden" name="action" value="add">
                <div class="auth__input">
                    Name: <input type="text" name="name" required>
                </div>
                <div class="auth__input">
                    Phone: <input type="text" name="phone_number" required>
                </div>
                <div class="auth__input">
                    NIC: <input type="text" name="nic" required>
                </div>
                <div class="auth__input">
                    License Number: <input type="text" name="license_number" required>
                </div>
                <div class="auth__input">
                    Vehicle ID: <input type="text" name="vehicle_id" required>
                </div>
                <button type="submit" class="auth__submit">Add Driver</button>
            </form>
        </div>

        <!-- Table Displaying Driver Data -->
        <h2>Driver Details</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone Number</th>
                <th>NIC</th>
                <th>License Number</th>
                <th>Vehicle ID</th>
                <th>Actions</th>
            </tr>

            <% 
                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement ps = conn.prepareStatement("SELECT * FROM drivers_megacity");
                     ResultSet rs = ps.executeQuery()) {

                    while (rs.next()) { 
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("phone_number") %></td>
                <td><%= rs.getString("nic") %></td>
                <td><%= rs.getString("license_number") %></td>
                <td><%= rs.getString("vehicle_id") %></td>
                <td>
                    <!-- Edit Button -->
                    <form action="DriverServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <input type="text" name="name" value="<%= rs.getString("name") %>" required>
                        <input type="text" name="phone_number" value="<%= rs.getString("phone_number") %>" required>
                        <input type="text" name="nic" value="<%= rs.getString("nic") %>" required>
                        <input type="text" name="license_number" value="<%= rs.getString("license_number") %>" required>
                        <input type="text" name="vehicle_id" value="<%= rs.getString("vehicle_id") %>" required>
                        <button type="submit">Update</button>
                    </form>

                    <!-- Delete Button -->
                    <form action="DriverServlet" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit" onclick="return confirm('Are you sure?')">Delete</button>
                    </form>
                </td>
            </tr>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </body>
</html>
