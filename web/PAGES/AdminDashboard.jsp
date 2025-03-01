<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DAO.DBConnection"%>
<%@page import="MODEL.Driver_Megacity"%>
<%@page import="DAO.Driver_MegacityDAO"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN - Mega City Cab</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />

    <!-- Styles -->
    <style>
        :root {
            text-decoration: none;
        }

        a {
            text-decoration: none;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: "Poppins", serif;
            background-color: #f5f5f5;
        }

        .main__container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            padding: 20px;
        }

        .auth__topic {
            font-size: 2rem;
            font-weight: 500;
            font-family: "DynaPuff", serif;
            color: #3D3D3D;
            text-align: center;
            margin-bottom: 20px;
        }

        .auth__container {
            width: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .auth__form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            width: 450px;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid lightgray;
            box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
        }

        input,
        .select {
            padding: 0.9rem;
            border-radius: 4px;
            border: 1px solid lightgray;
            box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
        }

        .auth__input {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .auth__submit {
            background-color: #3D3D3D;
            color: white;
            border: none;
            font-weight: 500;
            font-size: 1rem;
            padding: 0.9rem;
            cursor: pointer;
            margin-top: 20px;
        }

        .auth__submit:hover {
            background-color: #555;
        }

        .book__container_main {
            display: flex;
            gap: 60px;
            justify-content: center;
            align-items: center;
            margin: 20px 0;
        }

        .book__container {
            padding: 15px;
            background: white;
            border-radius: 4px;
            border: 1px solid lightgray;
            box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            max-width: 1200px;
            margin: auto;
        }

        .logo img {
            height: 50px;
        }

        .nav-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 400;
        }

        .nav-links a:hover {
            text-decoration: underline;
        }

        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            background-color: white;
        }

        table th,
        table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        table tr:hover {
            background-color: #f1f1f1;
        }

        button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            font-size: 0.9rem;
            border-radius: 4px;
        }

        button:hover {
            background-color: #d32f2f;
        }

        form input[type="text"] {
            margin: 5px 0;
            padding: 0.7rem;
            font-size: 0.9rem;
        }

        button[type="submit"] {
            padding: 10px 20px;
            font-size: 1rem;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <!-- Header Section -->
    <header class="header">
        <div class="logo">
            <img src="logo.png" alt="Mega City Cab Logo">
        </div>
        <nav class="nav-links">
            <a href="#">Dashboard</a>
            <a href="#">Logout</a>
        </nav>
    </header>

    <!-- Main Container -->
    <div class="main__container">

        <!-- Driver Registration Form -->
        <div class="auth__container">
            <h2 class="auth__topic">Add New Driver</h2>
            <form action="DriverServlet" method="post" class="auth__form">
                <input type="hidden" name="action" value="add">
                <div class="auth__input">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="auth__input">
                    <label for="phone_number">Phone:</label>
                    <input type="text" id="phone_number" name="phone_number" required>
                </div>
                <div class="auth__input">
                    <label for="nic">NIC:</label>
                    <input type="text" id="nic" name="nic" required>
                </div>
                <div class="auth__input">
                    <label for="license_number">License Number:</label>
                    <input type="text" id="license_number" name="license_number" required>
                </div>
                <div class="auth__input">
                    <label for="vehicle_id">Vehicle ID:</label>
                    <input type="text" id="vehicle_id" name="vehicle_id" required>
                </div>
                <button type="submit" class="auth__submit">Add Driver</button>
            </form>
        </div>

        <!-- Table Displaying Driver Data -->
        <h2 class="auth__topic">Driver Details</h2>
        <div class="book__container_main">
            <div class="book__container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Phone Number</th>
                            <th>NIC</th>
                            <th>License Number</th>
                            <th>Vehicle ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
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
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</body>
</html>
