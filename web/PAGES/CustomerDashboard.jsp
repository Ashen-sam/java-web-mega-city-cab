<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mega City Cab</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
        <style>
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 0;
                max-width: 1200px;
                margin: auto;
            }
            .logo img {
                height: 50px; /* Adjust as needed */
            }
            .nav-links {
                display: flex;
                gap: 20px;
                align-items: center; /* Space between links */
            }
            .nav-links a {
                text-decoration: none;
                color: #333;
                font-weight: 400;
            }
            .nav-links a:hover {
                text-decoration: underline;
            }
            .hidden {
                display: none; /* Class to hide elements */
            }
        </style>
        <script>
            function showAdditionalForm(event) {
                event.preventDefault(); // Prevent the default form submission
                document.getElementById("initialForm").classList.add("hidden"); // Hide the initial form
                document.getElementById("additionalForm").classList.remove("hidden"); // Show the additional form
            }

            function showInitialForm() {
                document.getElementById("additionalForm").classList.add("hidden"); // Hide the additional form
                document.getElementById("initialForm").classList.remove("hidden"); // Show the initial form
            }
        </script>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <h3>MegaCab</h3><!-- Replace with your logo path -->
            </div>
            <div class="nav-links">
                <a href="#">About</a>
                <a href="#">Help</a>
                <a href="#">Business</a>
                <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                    <input class="auth__submit" type="submit" value="Logout">
                </form>
            </div>
        </div>

        <div class="book__container_main">
            <!-- Initial Booking Form -->
            <form id="initialForm" class="auth__form book__container" onsubmit="showAdditionalForm(event)">
                <h3>Request a ride</h3>
                <div class="auth__input">
                    <label for="vehicleType">Vehicle Type:</label>
                    <select class="select" id="vehicleType" name="vehicleType" required>
                        <option value="" disabled selected>Select a vehicle type</option>
                        <option value="bike">Bike</option>
                        <option value="van">Van</option>
                        <option value="threewheeler">Three-Wheeler</option>
                    </select>
                </div>
                <div class="auth__input">
                    <label for="pickupLocation">Pickup Location:</label>
                    <input type="text" id="pickupLocation" name="pickupLocation" required>
                </div>
                <div class="auth__input">
                    <label for="dropLocation">Drop Location:</label>
                    <input type="text" id="dropLocation" name="dropLocation" required>
                </div>
                <div class="auth__input">
                    <label for="bookingDate">Booking Date:</label>
                    <input type="date" id="bookingDate" name="bookingDate" required>
                </div>
                <input class="auth__submit" type="submit" value="Book Vehicle">
            </form>

            <!-- Additional Form (hidden initially) -->
            <form style="position: relative" id="additionalForm" class="auth__form book__container hidden" action="<%=request.getContextPath()%>/submitBooking" method="post">
                <h3>Enter Your Details</h3>
                <div class="auth__input">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="auth__input">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <div class="auth__input">
                    <label for="phone">Phone Number:</label>
                    <input type="text" id="phone" name="phone" required>
                </div>
                <div class="auth__input">
                    <label for="phone">NIC</label>
                    <input type="text" id="phone" name="phone" required>
                </div>
                <input class="auth__submit" type="submit" value="Confirm Booking">
                <button style="position: absolute;top: 10px ;right: 10px" type="button" class="auth__submit" onclick="showInitialForm()">Back</button>
            </form>

            <div>
                <img height="460" src="../IMG/3-2-ridesharing-new.webp"/>
            </div>
        </div>
    </body>
</html>
