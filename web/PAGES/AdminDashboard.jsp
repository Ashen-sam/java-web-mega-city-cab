<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DAO.DBConnection"%>
<%@page import="MODEL.Driver_Megacity"%>
<%@page import="DAO.Driver_MegacityDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../STYLES/admin-styles.css" />
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />

        <title>Admin  - MegaCab</title>
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

            <div class="admin">
                <div class="admin-content">
                    <div class="content-header">
                        <h2 class="content-title">Driver Management</h2>
                        <button class="admin-btn" id="add-driver-btn">
                            <i class="fas fa-plus"></i> Add New Driver
                        </button>
                    </div>

                    <!-- Add Driver Form -->
                    <div class="driver-form">
                        <form action="DriverServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="form-grid">
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
                                    <label for="license_number">License Number</label>
                                    <input type="text" id="license_number" name="license_number" required>
                                </div>
                                <div class="form-group">
                                    <label for="vehicle_id">Vehicle ID</label>
                                    <input type="text" id="vehicle_id" name="vehicle_id" required>
                                </div>
                                <div class="form-group">
                                    <label for="status">Status</label>
                                    <select id="status" name="status" style="padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;">
                                        <option value="active">Active</option>
                                        <option value="inactive">Inactive</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-actions">
                                <button type="submit" class="admin-btn">
                                    <i class="fas fa-save"></i> Save Driver
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
                                <th>License No</th>
                                <th>Vehicle ID</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement("SELECT * FROM drivers_megacity"); ResultSet rs = ps.executeQuery()) {

                                    while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getInt("id")%></td>
                                <td><%= rs.getString("name")%></td>
                                <td><%= rs.getString("phone_number")%></td>
                                <td><%= rs.getString("nic")%></td>
                                <td><%= rs.getString("license_number")%></td>
                                <td><%= rs.getString("vehicle_id")%></td>
                                <td><span class="status-active">Active</span></td>
                                <td>
                                    <div class="action-buttons">
                                        <form action="DriverServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="id" value="<%= rs.getInt("id")%>">
                                            <button type="button" class="edit-btn" onclick="openEditForm(<%= rs.getInt("id")%>)">
                                                <i class="fas fa-edit"></i> Edit
                                            </button>
                                        </form>
                                        <form action="DriverServlet" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<%= rs.getInt("id")%>">
                                            <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this driver?')">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </button>
                                        </form>
                                    </div>
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

        <div class="edit-form-popup" id="editFormPopup">
            <div class="edit-form-content">
                <div class="edit-form-header">
                    <h3>Edit Driver</h3>
                    <span class="close-btn" onclick="closeEditForm()">&times;</span>
                </div>
                <form action="DriverServlet" method="post">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" id="edit-id" name="id" value="">
                    <div class="form-group">
                        <label for="edit-name">Full Name</label>
                        <input type="text" id="edit-name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-phone">Phone Number</label>
                        <input type="text" id="edit-phone" name="phone_number" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-nic">NIC</label>
                        <input type="text" id="edit-nic" name="nic" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-license">License Number</label>
                        <input type="text" id="edit-license" name="license_number" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-vehicle">Vehicle ID</label>
                        <input type="text" id="edit-vehicle" name="vehicle_id" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-status">Status</label>
                        <select id="edit-status" name="status" style="padding: 10px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                    <div class="form-actions" style="margin-top: 20px;">
                        <button type="submit" class="admin-btn">
                            <i class="fas fa-save"></i> Update Driver
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openEditForm(id) {
                document.getElementById('edit-id').value = id;
                document.getElementById('editFormPopup').style.display = 'flex';
            }

            function closeEditForm() {
                document.getElementById('editFormPopup').style.display = 'none';
            }
        </script>
    </body>
</html>