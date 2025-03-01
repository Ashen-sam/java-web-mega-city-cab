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
            .container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 20px;
                border-radius: 10px;

            }
            .text-section {
                max-width: 50%;
            }
            .benefits {
                background-color: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .button {
                background-color: black;
                color: white;
                padding: 10px 20px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                margin-top: 10px;
            }
            .container__flex{
                max-width: 1100px;
                margin: auto;

            }
            .text-align{
                max-width: 1100px;
                margin: 80px auto 0 auto;
                text-align:center;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <h3>MegaCab</h3>
            </div>
            <div class="nav-links">
                <a href="../PAGES/About.jsp">About</a>
                <a href="#">Help</a>
                <a href="../PAGES/Business.jsp">Business</a>
                <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                    <input class="auth__submit" type="submit" value="Logout">
                </form>
            </div>
        </div>

        <div class="book__container_main">
            <!-- Initial Booking Form -->
            <form id="initialForm" class="auth__form book__container" onsubmit="showAdditionalForm(event)">
                <h3>Request a ride</h3>
                <h3>Price: <span id="priceDisplay">Select locations</span></h3>
                <div class="auth__input">
                    <label for="vehicleType">Vehicle Type:</label>
                    <select class="select" id="vehicleType" name="vehicleType" required>
                        <option value="" disabled selected>Select a vehicle type</option>
                        <option value="bike">Bike</option>
                        <option value="threewheeler">Three-Wheeler</option>
                        <option value="van">Van</option>
                    </select>
                </div>
                <div class="auth__input">
                    <label for="pickupLocation">Pickup Location:</label>
                    <input type="text" id="pickupLocation" name="pickupLocation" list="colomboLocations" placeholder="e.g. Colombo Fort" required>
                    <datalist id="colomboLocations">
                        <option value="Colombo Fort">
                        <option value="Colombo 3">
                        <option value="Colombo 5">
                        <option value="Colombo 7">
                        <option value="Colombo 8">
                        <option value="Colombo 10">
                        <option value="Colombo 12">
                        <option value="Colombo 13">
                    </datalist>
                </div>
                <div class="auth__input">
                    <label for="dropLocation">Drop Location:</label>
                    <input type="text" id="dropLocation" name="dropLocation" list="colomboLocations" placeholder="e.g. Colombo 7" required>
                </div>
                <div class="auth__input">
                    <label for="bookingDate">Booking Date:</label>
                    <input type="date" id="bookingDate" name="bookingDate" required>
                </div>
                <input class="auth__submit" type="submit" value="Book Vehicle">
            </form>

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
                <img height="460" src="../IMG/online-cab-booking-illustration-download-in-svg-png-gif-file-formats--order-taxi-app-service-pack-services-illustrations-3013176.webp"/>
            </div>
        </div>
    
    </body>
    <script src="../VALIDATIONS/priceCalculate.js"></script>
</html>
