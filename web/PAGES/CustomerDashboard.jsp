<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Customer Dashboard</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
    </head>
    <body>
        <div class="back_customer"></div>
        <div class="auth__container">
            <form class="auth__form book__container" action="<%=request.getContextPath()%>/bookVehicle" method="post">
                <h3>Book a Vehicle</h3>
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
                <div class="auth__input">
                    <label for="bookingTime">Booking Time:</label>
                    <input type="time" id="bookingTime" name="bookingTime" required>
                </div>
                <input class="auth__submit" type="submit" value="Book Vehicle">
            </form>

            <!--        <h2>Booking Result</h2>
                    <p>
            <%
                String message = (String) request.getAttribute("message");
                out.println(message != null ? message : "No message available.");
            %>
        </p>-->
        </div>
    </body>
</html>
