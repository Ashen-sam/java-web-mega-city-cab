<%-- 
    Document   : Business
    Created on : Mar 1, 2025, 4:52:55 PM
    Author     : Ashen Samarasekera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BUSINESS</title>  <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
    </head>
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
    <body>
        <div class="header">
            <div class="logo">
                <h3>MegaCab</h3>
            </div>
            <div class="nav-links">
                <a href="../PAGES/About.jsp">About</a>
                <a href="#">Help</a>
                <a href="#">Business</a>
                <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                    <input class="auth__submit" type="submit" value="Logout">
                </form>
            </div>
        </div>

        <div class="text-align">
            <h3 >Get your ride right with Uber Reserve</h3>
            <p>Choose date and time</p>
        </div>
        <div class="container__flex">
            <div class="container">
                <div class="text-section">

                    <h3>Benefits</h3>
                    <ul>
                        <li>📅 Choose your exact pickup time up to 90 days in advance.</li>
                        <li>⏳ Extra wait time included to meet your ride.</li>
                        <li>❌ Cancel at no charge up to 60 minutes in advance.</li>
                    </ul>
                </div>
                <img src="../IMG/online-taxi-booking-illustration-download-in-svg-png-gif-file-formats--car-cab-city-service-pack-holidays-illustrations-4046973.webp" alt="Uber Reserve" width="300">
            </div>

            <div class="container">
                <img src="../IMG/cab-app-illustration-download-in-svg-png-gif-file-formats--phone-online-car-booking-mobile-apps-and-services-pack-design-development-illustrations-3742564.webp" alt="Uber Reserve" width="300">

                <div class="text-section">
                    <h3>Get your ride right with Uber Reserve</h3>
                    <p>Choose date and time</p>
                    <h3>Benefits</h3>
                    <ul>
                        <li>📅 Choose your exact pickup time up to 90 days in advance.</li>
                        <li>⏳ Extra wait time included to meet your ride.</li>
                        <li>❌ Cancel at no charge up to 60 minutes in advance.</li>
                    </ul>
                </div>
            </div>

            <div class="benefits">
                <h3>Benefits</h3>
                <ul>
                    <li>📅 Choose your exact pickup time up to 90 days in advance.</li>
                    <li>⏳ Extra wait time included to meet your ride.</li>
                    <li>❌ Cancel at no charge up to 60 minutes in advance.</li>
                </ul>
                <a href="#">See terms</a>
            </div>
        </div>
    </body>
</html>
