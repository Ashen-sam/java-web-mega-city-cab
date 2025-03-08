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
            <form id="initialForm" class="auth__form book__container" action="<%=request.getContextPath()%>/BookingServlet" method="post" >
                <div>
                    <p>Request a ride</p>
                    <p>Price: <span id="priceDisplay">Select locations</span></p>
                </div>
                <div class="auth__input">
                    <select class="select" id="vehicleType" name="vehicleType" required>
                        <option value="" disabled selected>Select a vehicle type</option>
                        <option value="bike">Bike</option>
                        <option value="threewheeler">Three-Wheeler</option>
                        <option value="van">Van</option>
                    </select>
                </div>
                <div class="auth__input">
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
                    <input type="text" id="dropLocation" name="dropLocation" list="colomboLocations" placeholder="e.g. Colombo 7" required>
                </div>
                <div class="auth__input">
                    <input type="date" id="bookingDate" name="bookingDate" required>
                </div>

                <input type="text" name="name" placeholder="Full Name" required>
                <input type="email" name="email" placeholder="Email Address" required>
                <input type="tel" name="phone" placeholder="Phone Number" required>
                <input type="text" name="nic" placeholder="NIC" required>
                <input class="auth__submit" type="submit" value="Book Vehicle">
                 <input type="hidden" id="price" name="price" value="" />
            </form>



            <div>
                <img height="460" src="../IMG/online-cab-booking-illustration-download-in-svg-png-gif-file-formats--order-taxi-app-service-pack-services-illustrations-3013176.webp"/>
            </div>
        </div>

    </body>
    <script src="../VALIDATIONS/priceCalculate.js"></script>
</html>
