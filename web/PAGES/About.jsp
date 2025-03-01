<%-- 
    Document   : About
    Created on : Mar 1, 2025, 4:47:15 PM
    Author     : Ashen Samarasekera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ABOUT</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
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
        .hidden {
            display: none; 
        }
        .container {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            max-width: 1100px;
            margin: auto;
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
    <body>  <div class="header">
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

        <section id="about" class="about-section">
            <div class="container">

                <h2>About Mega City Cab</h2>

                <<img src="../IMG/online-cab-booking-illustration-download-in-svg-png-gif-file-formats--taxi-service-application-car-book-pack-vehicle-illustrations-3932809.webp" alt="alt"/>
                <p>
                    Welcome to Mega City Cab, your trusted partner for reliable and efficient transportation in Colombo. Our mission is to provide a convenient, safe, and affordable cab service that meets the needs of both locals and visitors.

                    With a fleet of well-maintained vehicles and professional drivers, we offer a range of services designed to make your travel experience as smooth as possible. Whether you're heading to the airport, going to work, or exploring the city, we’ve got you covered with our on-demand booking system.

                    At Mega City Cab, customer satisfaction is our top priority. We use the latest technology to ensure timely arrivals, competitive pricing, and a hassle-free journey. Our easy-to-use platform allows you to book a ride with just a few clicks, and our drivers are always ready to take you wherever you need to go.

                    We are committed to offering a service that not only meets your transportation needs but exceeds your expectations. Choose Mega City Cab for your next ride, and experience the difference!
                </p>
            </div>
        </section>

    </body>
</html>
