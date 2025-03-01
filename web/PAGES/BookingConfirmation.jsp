<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Confirmation</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
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
            }
            .auth__container {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 80vh;
                justify-content: center;
            }
            .auth__form {
                display: flex;
                flex-direction: column;
                gap: 10px;
                width: 400px;
            }
            input {
                padding: 0.9rem;
                border-radius: 4px;
                border: 1px solid lightgray;
                box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
            }
            .auth__submit {
                background-color: #3D3D3D;
                color: white;
                border: none;
                font-weight: 500;
                font-size: 0.9rem;
                padding: 0.9rem;
                margin-top: 5px;
                cursor: pointer;
            }
            .auth__submit:hover {
                background-color: #2a2a2a;
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
    </head>
    <body>
        <div class="header">
            <div class="logo">
                <h3>MegaCab</h3>
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
              <div>
                  <img height="460" src="../IMG/online-cab-booking-illustration-download-in-svg-png-gif-file-formats--taxi-service-application-car-book-pack-vehicle-illustrations-3932809.webp"/>
            </div>
            <form class="auth__form book__container" action="submitBooking.jsp" method="POST">
                            <h2>Booking Form</h2>

                <input type="text" name="name" placeholder="Full Name" required>
                <input type="email" name="email" placeholder="Email Address" required>
                <input type="tel" name="phone" placeholder="Phone Number" required>
                <input type="text" name="nic" placeholder="NIC" required>
                <button type="submit" class="auth__submit">Submit</button>
            </form>
        </div>
    </body>
</html>
