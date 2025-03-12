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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About MegaCab</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="stylesheet" href="../STYLES/about-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

    </head>
    <body>
        <div class="header">
            <div class="logo">
                <i class="fas fa-taxi" style="font-size: 24px;"></i>
                <h3>                <a href="../PAGES/CustomerDashboard.jsp">MegaCab</a>
                </h3>
            </div>
            <div class="nav-links">
                <a href="../PAGES/About.jsp">About</a>
                <a href="../PAGES/Business.jsp">Business</a>
                <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                    <input class="auth__submit" type="submit" value="Logout">
                </form>
            </div>
        </div>

        <section class="about-hero">
            <h1>About MegaCab</h1>
            <p>Your trusted transportation partner in the city. Providing safe, reliable, and affordable rides since 2019.</p>
        </section>

        <div class="text-align">
            <h2>Our Story</h2>
            <p>Learn about our journey to becoming the leading ride service in the city</p>
        </div>

        <div class="container__flex">
            <div class="container">
                <div class="text-section">
                    <h3>Our Mission</h3>
                    <p>At MegaCab, our mission is to provide a convenient, safe, and affordable cab service that meets the needs of both locals and visitors. We're committed to revolutionizing urban transportation by offering seamless, technology-driven solutions that make getting around the city easier than ever before.</p>
                    <p>We strive to create value for our customers, drivers, and communities by providing reliable transportation options that reduce congestion, minimize environmental impact, and enhance urban mobility for everyone.</p>
                </div>
                <img src="../IMG/online-taxi-booking-illustration-download-in-svg-png-gif-file-formats--car-cab-city-service-pack-holidays-illustrations-4046973.webp" alt="MegaCab Mission">
            </div>

            <div class="container">
                <img src="../IMG/online-cab-booking-illustration-download-in-svg-png-gif-file-formats--taxi-service-application-car-book-pack-vehicle-illustrations-3932809.webp" alt="MegaCab Vision">
                <div class="text-section">
                    <h3>Our Vision</h3>
                    <p>We envision a future where transportation is effortless, accessible, and sustainable for everyone. By leveraging cutting-edge technology and a customer-centric approach, MegaCab aims to become the preferred transportation partner for individuals and businesses across the city.</p>
                    <p>Our goal is to build a transportation ecosystem that connects people, places, and opportunities while maintaining the highest standards of safety, reliability, and convenience.</p>
                </div>
            </div>
        </div>

        <section class="values-section">
            <div class="text-align">
                <h2>Our Core Values</h2>
                <p>The principles that guide everything we do</p>
            </div>
            <div class="values-grid">
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3>Safety First</h3>
                    <p>We prioritize the safety of our passengers and drivers above all else. Our rigorous safety protocols, driver verification processes, and vehicle maintenance standards ensure that every ride is a safe journey.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fas fa-handshake"></i>
                    </div>
                    <h3>Reliability</h3>
                    <p>We understand that punctuality matters. That's why we're committed to providing reliable transportation services that arrive on time, every time, so you can plan your day with confidence.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fas fa-user-friends"></i>
                    </div>
                    <h3>Customer Focus</h3>
                    <p>Our customers are at the heart of everything we do. We continuously listen to feedback and adapt our services to meet your evolving needs, ensuring an exceptional experience with every ride.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">
                        <i class="fas fa-seedling"></i>
                    </div>
                    <h3>Sustainability</h3>
                    <p>We're committed to reducing our environmental footprint through efficient routing, a growing fleet of electric vehicles, and eco-friendly operational practices that contribute to a greener future.</p>
                </div>
            </div>
        </section>


        <section class="cta-section">
            <div class="cta-container">
                <h2>Experience the MegaCab Difference</h2>
                <p>Join thousands of satisfied customers who rely on MegaCab for their daily transportation needs.</p>
                <div class="cta-buttons">
                    <a href="#" class="primary-btn">Book a Ride</a>
                    <a href="../PAGES/Business.jsp" class="secondary-btn">Business Solutions</a>
                </div>
            </div>
        </section>

        <footer class="footer">
            <div class="footer-container">
                <div class="footer-grid">
                    <div class="footer-logo">
                        <h3>MegaCab</h3>
                        <p>Your reliable transportation partner in the city. Available 24/7 to take you where you need to go, safely and comfortably.</p>
                        <div class="social-icons">
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="footer-links">
                        <h4>Quick Links</h4>
                        <ul>
                            <li><a href="../PAGES/About.jsp">About Us</a></li>
                            <li><a href="#">Our Services</a></li>
                            <li><a href="../PAGES/Business.jsp">Business Solutions</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Contact Us</a></li>
                        </ul>
                    </div>
                    <div class="footer-links">
                        <h4>Our Services</h4>
                        <ul>
                            <li><a href="#">City Rides</a></li>
                            <li><a href="#">Airport Transfers</a></li>
                            <li><a href="#">Hourly Rentals</a></li>
                            <li><a href="#">Intercity Travel</a></li>
                            <li><a href="#">Luxury Rides</a></li>
                        </ul>
                    </div>
                    <div class="footer-links">
                        <h4>Support</h4>
                        <ul>
                            <li><a href="#">Help Center</a></li>
                            <li><a href="#">Safety Guidelines</a></li>
                            <li><a href="#">COVID-19 Precautions</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Terms of Service</a></li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>&copy; 2025 MegaCab. All rights reserved.</p>
                </div>
            </div>
        </footer>
    </body>
</html>