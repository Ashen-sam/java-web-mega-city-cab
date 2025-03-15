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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MegaCab Business Solutions</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="stylesheet" href="../STYLES/business-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    </head>

    <body>
              <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            if (username == null) {
                // Redirect to login page if not logged in
                response.sendRedirect(request.getContextPath() + "/PAGES/Login.jsp");
                return;
            }
        %>
        <div class="header">
            <div class="logo">
                <i class="fas fa-taxi" style="font-size: 24px;"></i>
                <h3>MegaCab</h3>
            </div>
            <div class="nav-links">
                <a href="../PAGES/About.jsp">About</a>
                <a href="#">Business</a>
                <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                    <input class="auth__submit" type="submit" value="Logout">
                </form>
                <Button class="auth__submit " style="display: flex;justify-content: center;align-items:center;gap:10px">
                    <i class="fa-solid fa-user"></i>
                    <p><%= username%></p>

                </Button>
            </div>
        </div>

        <section class="business-hero">
            <h1>MegaCab for Business</h1>
            <p>Streamline your corporate transportation needs with our dedicated business solutions. Save time, reduce costs, and keep your team moving efficiently.</p>
            <div class="cta-buttons">
                <a href="#contact-form" class="primary-btn">Contact Sales</a>
                <a href="#benefits" class="secondary-btn">See Benefits</a>
            </div>
        </section>

        <div class="text-align">
            <h2>Business Transport Solutions</h2>
            <p>Customized transportation services designed for your business needs</p>
        </div>

        <div class="container__flex">
            <div class="container">
                <div class="text-section">
                    <h3>MegaCab Reserve</h3>
                    <p>Plan ahead with our reservation service that ensures your team always has a ride when needed.</p>
                    <h3>Benefits</h3>
                    <ul>
                        <li><i class="far fa-calendar-alt"></i> Choose your exact pickup time up to 90 days in advance.</li>
                        <li><i class="far fa-clock"></i> Extra wait time included to meet your ride.</li>
                        <li><i class="far fa-times-circle"></i> Cancel at no charge up to 60 minutes in advance.</li>
                    </ul>
                </div>
                <img src="../IMG/online-taxi-booking-illustration-download-in-svg-png-gif-file-formats--car-cab-city-service-pack-holidays-illustrations-4046973.webp" alt="MegaCab Reserve">
            </div>

            <div class="container">
                <img src="../IMG/cab-app-illustration-download-in-svg-png-gif-file-formats--phone-online-car-booking-mobile-apps-and-services-pack-design-development-illustrations-3742564.webp" alt="MegaCab Business App">
                <div class="text-section">
                    <h3>Business Dashboard</h3>
                    <p>Manage all your transportation needs from one centralized platform. Track expenses, monitor usage, and optimize your transportation budget.</p>
                    <h3>Key Features</h3>
                    <ul>
                        <li><i class="fas fa-chart-line"></i> Real-time expense tracking and reporting</li>
                        <li><i class="fas fa-users"></i> Manage multiple team members from one account</li>
                        <li><i class="fas fa-receipt"></i> Automated invoicing and receipt management</li>
                    </ul>
                </div>
            </div>
        </div>

        <section class="business-solutions">
            <div class="solutions-title">
                <h2>Comprehensive Business Solutions</h2>
                <p>Choose the right transportation solution for your business needs</p>
            </div>
            <div class="solutions-grid">
                <div class="solution-card">
                    <div class="solution-icon">
                        <i class="fas fa-building"></i>
                    </div>
                    <h3>Corporate Accounts</h3>
                    <p>Set up a corporate account with dedicated support, centralized billing, and customized reporting for your business needs.</p>
                    <a href="#">Learn more <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="solution-card">
                    <div class="solution-icon">
                        <i class="fas fa-plane-arrival"></i>
                    </div>
                    <h3>Airport Transfers</h3>
                    <p>Reliable airport transportation for your team with flight tracking, wait time, and seamless coordination.</p>
                    <a href="#">Learn more <i class="fas fa-arrow-right"></i></a>
                </div>
                <div class="solution-card">
                    <div class="solution-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3>Event Transportation</h3>
                    <p>Coordinate transportation for conferences, meetings, and corporate events with ease.</p>
                    <a href="#">Learn more <i class="fas fa-arrow-right"></i></a>
                </div>
            </div>
        </section>
        <section id="benefits" class="benefits-section">
            <div class="benefits">
                <h3>Why Choose MegaCab for Business</h3>
                <ul>
                    <li><i class="fas fa-money-bill-wave"></i> <span>Reduce transportation costs with volume discounts and efficient routing</span></li>
                    <li><i class="fas fa-clock"></i> <span>Save time with priority booking and guaranteed availability</span></li>
                    <li><i class="fas fa-chart-pie"></i> <span>Gain visibility into transportation spending with detailed analytics</span></li>
                    <li><i class="fas fa-shield-alt"></i> <span>Enhanced safety protocols for all business travelers</span></li>
                    <li><i class="fas fa-headset"></i> <span>Dedicated business support team available 24/7</span></li>
                </ul>
                <a href="#">See terms and conditions</a>
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
                        <h4>Business Solutions</h4>
                        <ul>
                            <li><a href="#">Corporate Accounts</a></li>
                            <li><a href="#">Event Transportation</a></li>
                            <li><a href="#">Airport Transfers</a></li>
                            <li><a href="#">Business Travel</a></li>
                            <li><a href="#">Enterprise Dashboard</a></li>
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