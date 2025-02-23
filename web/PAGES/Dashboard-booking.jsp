<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mega City Cab</title>
        <link rel="stylesheet" href="../STYLES/booking-styles.css"/>
    </head>
    <body>

        <div>
            <h1>Booking Form</h1>
            <form action="<%=request.getContextPath()%>/BookingServlet" method="post">
                <div class="row">
                    <label for="pickup">Pickup Location:</label>
                    <input type="text" id="pickup" name="pickup" required>
                </div>
                <div class="row">
                    <label for="drop">Drop Location:</label>
                    <input type="text" id="drop" name="drop" required>
                </div>
                <div class="row">
                    <label for="date">Date:</label>
                    <input type="date" id="date" name="date" required>
                </div>
                <div class="row">
                    <label for="nic">NIC Number:</label>
                    <input type="text" id="nic" name="nic" required>
                </div>
                <div class="row">
                    <label for="mobile">Mobile Number:</label>
                    <input type="tel" id="mobile" name="mobile" required>
                </div>
                <div class="row">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <button type="submit">Submit</button>
            </form>
        </div>

    </body>
</html>
