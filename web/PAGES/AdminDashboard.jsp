<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DAO.DBConnection"%>
<%@page import="MODEL.Driver_Megacity"%>
<%@page import="DAO.DriverDashboardDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../STYLES/admin-styles.css" />
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />

        <title>Admin - MegaCab</title>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

    </head>
    <body>
        <%
            String username = "";
            if (session != null && session.getAttribute("username") != null) {
                username = (String) session.getAttribute("username");
            }
        %>
        <div class="admin-container">
            <div class="admin-header">
                <Button class="admin-btn " style="display: flex;justify-content: center;align-items:center;gap:10px">
                    <i class="fa-solid fa-user"></i>
                    <p><%= username%></p>

                </Button>
                <div class="admin-actions">

                    <form action="<%=request.getContextPath()%>/LogoutServlet" method="post" style="display: inline;">
                        <button type="submit" class="admin-btn">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </button>
                    </form>
                </div>
            </div>
            <% if (session.getAttribute("errorMessage") != null) {%>
            <div class="alert-message" id="alert-message" style="margin-bottom: 15px; text-align: center;">
                <%= session.getAttribute("errorMessage")%>
            </div>
            <% session.removeAttribute("errorMessage"); %>
            <% }%>
            <div class="admin">
                <div class="admin-content">

                    <div class="driver-form">
                        <h3>Add New Driver</h3>
                        <form  action="<%=request.getContextPath()%>/AdminDriverServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="form-grid">
                                <!-- User Account Information -->
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" id="username" name="username" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" id="password" name="password" required>
                                </div>

                                <!-- Personal Information -->
                                <div class="form-group">
                                    <label for="name">Full Name</label>
                                    <input type="text" id="name" name="name" required>
                                </div>
                                <div class="form-group">
                                    <label for="phone_number">Phone Number</label>
                                    <input type="text" id="phone_number" name="phone_number" required>
                                </div>
                                <div class="form-group">
                                    <label for="nic">NIC</label>
                                    <input type="text" id="nic" name="nic" required>
                                </div>
                                <div class="form-group">
                                    <label for="license_plate">license_plate</label>
                                    <input type="text" id="license_plate" name="license_plate" required>
                                </div>
                                <!--                                <div class="form-group">
                                                                    <label for="model">model</label>
                                                                    <input type="text" id="model" name="model" required>
                                                                </div>-->
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select class="select" style='width:400px' id="gender" name="gender" required>
                                        <option value="">Select Gender</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input id="address" name="address" rows="3" required></input>
                                </div>
                                <div class="form-group">
                                    <label for="license_number">License Number</label>
                                    <input type="text" id="license_number" name="license_number" required>
                                </div>

                                <div class="form-group">
                                    <label for="vehicle_type">Vehicle Type</label>

                                    <select style='width:400px' id="vehicle_type" name="vehicle_type" class="select" required>
                                        <option value="Bike">Bike</option>
                                        <option value="Car">Car</option>
                                        <option value="Van">Van</option>
                                        <option value="Three_Wheeler">Three Wheeler</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="vehicle_registration">Vehicle Registration Number</label>
                                    <input type="text" id="vehicle_registration_number" name="vehicle_registration_number" required>
                                </div>
                                <div class="form-group">
                                    <label for="vehicle_model">Vehicle Make and Model</label>
                                    <input type="text" id="vehicle_make_model" name="vehicle_make_model" required>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" style="margin-right: 5px" class="admin-btn">
                                    <i class="fas fa-plus"></i> Add Driver
                                </button>
                            </div>
                        </form>
                    </div>

                    <table class="driver-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>NIC</th>
                                <th>Gender</th>
                                <th>License No</th>
                                <th>Vehicle Type</th>
                                <th>Vehicle Reg</th>
                                <th>Vehicle Model</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    DriverDashboardDAO driverDAO = new DriverDashboardDAO();
                                    List<Driver_Megacity> driverList = driverDAO.getAllDrivers();

                                    for (Driver_Megacity driver : driverList) {
                            %>
                            <tr>
                                <td><%= driver.getDriverId()%></td>
                                <td><%= driver.getName()%></td>
                                <td><%= driver.getPhoneNumber()%></td>
                                <td><%= driver.getNic()%></td>
                                <td><%= driver.getGender()%></td>
                                <td><%= driver.getLicenseNumber()%></td>
                                <td><%= driver.getVehicleType()%></td>
                                <td><%= driver.getVehicleRegistrationNumber()%></td>
                                <td><%= driver.getVehicleMakeModel()%></td>
                                <td>
                                    <button type="button" class="edit-btn" onclick="editDriver(<%= driver.getDriverId()%>, '<%= driver.getName()%>', '<%= driver.getPhoneNumber()%>', '<%= driver.getNic()%>', '<%= driver.getGender()%>', '<%= driver.getAddress()%>', '<%= driver.getLicenseNumber()%>', '<%= driver.getVehicleType()%>', '<%= driver.getVehicleRegistrationNumber()%>', '<%= driver.getVehicleMakeModel()%>')">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <form action="<%=request.getContextPath()%>/AdminDriverServlet" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="driverID" value="<%= driver.getDriverId()%>">
                                        <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this driver?')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("<tr><td colspan='10'>Error retrieving driver data: " + e.getMessage() + "</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>


                </div>
            </div>
        </div>



        <script>
            function editDriver(driverID, name, phoneNumber, nic, gender, address, licenseNumber, vehicleType, vehicleRegistration, vehicleModel) {
                // Change form title
                document.querySelector('.driver-form h3').textContent = "Edit Driver";

                // Set form action to update
                document.querySelector('input[name="action"]').value = "update";

                // Add a hidden field for the driver ID
                if (!document.getElementById('driverIDField')) {
                    const hiddenField = document.createElement('input');
                    hiddenField.type = 'hidden';
                    hiddenField.id = 'driverIDField';
                    hiddenField.name = 'driverID';
                    document.querySelector('.driver-form form').appendChild(hiddenField);
                }
                document.getElementById('driverIDField').value = driverID;

                // Fill form fields with current data
                document.getElementById('name').value = name;
                document.getElementById('phone_number').value = phoneNumber;
                document.getElementById('nic').value = nic;
                document.getElementById('gender').value = gender;
                document.getElementById('address').value = address;
                document.getElementById('license_number').value = licenseNumber;
                document.getElementById('vehicle_type').value = vehicleType;
                document.getElementById('vehicle_registration_number').value = vehicleRegistration;
                document.getElementById('vehicle_make_model').value = vehicleModel;

                // Disable username and password fields for edit mode
                document.getElementById('username').disabled = true;
                document.getElementById('password').disabled = true;
                document.getElementById('username').value = "driver" + driverID; // Just for display
                document.getElementById('password').value = "********"; // Placeholder

                // Change button text
                const submitButton = document.querySelector('.driver-form button[type="submit"]');
                submitButton.innerHTML = '<i class="fas fa-save"></i> Update Driver';

                // Scroll to form
                document.querySelector('.driver-form').scrollIntoView({behavior: 'smooth'});
            }

            // Function to reset form to add mode
            function resetToAddMode() {
                document.querySelector('.driver-form h3').textContent = "Add New Driver";
                document.querySelector('input[name="action"]').value = "add";
                document.querySelector('.driver-form form').reset();

                // Enable username and password fields
                document.getElementById('username').disabled = false;
                document.getElementById('password').disabled = false;

                // Change button text back
                const submitButton = document.querySelector('.driver-form button[type="submit"]');
                submitButton.innerHTML = '<i class="fas fa-plus"></i> Add Driver';
            }

            // Add a reset button to the form
            document.addEventListener('DOMContentLoaded', function () {
                const formActions = document.querySelector('.form-actions');
                const resetButton = document.createElement('button');
                resetButton.type = 'button';
                resetButton.className = 'admin-btn';
                resetButton.innerHTML = '<i class="fas fa-undo"></i> Cancel';
                resetButton.onclick = resetToAddMode;
                formActions.appendChild(resetButton);
            });
        </script>
    </body>
</html>