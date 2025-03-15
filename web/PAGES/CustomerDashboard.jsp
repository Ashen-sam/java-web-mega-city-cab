<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.Booking_Megacity"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*, DAO.DBConnection"%>
<%@page import="MODEL.Driver_Megacity"%>
<%@page import="DAO.BookingDataDAO"%>
<%@page import="DAO.Customer_MegacityDAO"%>
<%

    if ("POST".equalsIgnoreCase(request.getMethod()) && "booking".equals(request.getParameter("formType"))) {
        request.getRequestDispatcher("/BookingServlet").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Mega City Cab - Your Reliable Ride Partner</title>
        <link rel="icon" href="favicon.ico" type="image/x-icon">

        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="stylesheet" href="../STYLES/main-page-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <style>
            .user-dropdown {
                position: relative;
                display: inline-block;
            }

            .bookings-dropdown {
                display: none;
                position: absolute;
                right: 100px;
                top:70px;
                background-color: white;
                min-width: 350px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1000;
                border-radius: 8px;
                padding: 15px;
                max-height: 400px;
                overflow-y: auto;
            }

            .bookings-dropdown.show {
                display: block;
            }

            .booking-item {
                padding: 10px;
                border-bottom: 1px solid #f1f1f1;
                transition: background-color 0.3s;
            }

            .booking-item:last-child {
                border-bottom: none;
            }

            .booking-item:hover {
                background-color: #f9f9f9;
            }

            .booking-id {
                font-weight: bold;
                color: #333;
            }

            .booking-detail {
                margin: 5px 0;
                font-size: 14px;
                color: #555;
            }

            .booking-status {
                display: inline-block;
                padding: 3px 8px;
                border-radius: 4px;
                font-size: 12px;
                font-weight: bold;
                background-color: #4CAF50;
                color: white;
            }

            .no-bookings {
                padding: 15px;
                text-align: center;
                color: #666;
            }

            .dropdown-header {
                padding: 10px;
                background-color: #f1f1f1;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
                font-weight: bold;
                text-align: center;
                margin: -15px -15px 10px -15px;
            }
        </style>
    </head>

    <body>
        <%
            String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect(request.getContextPath() + "/PAGES/Login.jsp");
                return;
            }
            // Get approved bookings for this customer
            List<Booking_Megacity> approvedBookings = null;
            try {
                approvedBookings = Customer_MegacityDAO.getApprovedBookingsForCustomer(username);
            } catch (Exception e) {
                // Handle exception silently - will show "No approved bookings" message
                approvedBookings = new ArrayList<>();
            }
        %>



        <div class="header">
            <div class="logo">
                <i class="fas fa-taxi" style="font-size: 24px;"></i>
                <h3>Mega Cab</h3>
            </div>
            <div class="nav-links">

                <a href="../PAGES/About.jsp">About</a>
                <a href="../PAGES/Business.jsp">Business</a>

                <Button class="auth__submit " style="display: flex;justify-content: center;align-items:center;gap:10px">
                    <i class="fa-solid fa-user"></i>
                    <p><%= username%></p>   

                </Button>
                <Button id="userDropdownBtn" class="auth__submit " style="display: flex;justify-content: center;align-items:center;gap:10px">
                    <i class="fa-solid fa-taxi"></i>
                    <p>Bookings</p>   

                </Button>
                <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                    <input style='border:none;background-color: transparent;box-shadow: none;font-size: 16px;font-weight: 500' type="submit" value="Logout">
                </form>
                <!-- Approved Bookings Dropdown -->
                <div id="bookingsDropdown" class="bookings-dropdown">
                    <div class="dropdown-header">Your Approved Bookings</div>
                    <% if (approvedBookings != null && !approvedBookings.isEmpty()) { %>
                    <% for (Booking_Megacity booking : approvedBookings) {%>
                    <div class="booking-item">
                        <div class="booking-id">Booking #<%= booking.getBookingId()%></div>
                        <div class="booking-detail">
                            <i class="fas fa-map-marker-alt"></i> From: <%= booking.getPickupLocation()%>
                        </div>
                        <div class="booking-detail">
                            <i class="fas fa-map-marker"></i> To: <%= booking.getDropLocation()%>
                        </div>
                        <div class="booking-detail">
                            <i class="fas fa-calendar"></i> Date: <%= booking.getBookingDate()%>
                        </div>
                        <div class="booking-detail">
                            <i class="fas fa-money-bill"></i> Price: Rs <%= String.format("%.2f", booking.getPrice())%>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-status">Approved</span>
                        </div>
                    </div>
                    <% } %>
                    <% } else { %>
                    <div class="no-bookings">
                        <i class="fas fa-info-circle"></i> No approved bookings found.
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <%
        String message = (String) session.getAttribute("message");
        if (message != null) {
    %>
    <div class="alert-message <%= message.contains("successful") ? "alert-success" : "alert-error"%>" id="alertMessage">
        <div class="alert ">
            <%= message%>
            <button class='alert_btn' onclick="document.getElementById('alertMessage').style.display = 'none'" class="close-btn">×</button>
        </div>
    </div>
    <%
            // Remove the message from session after displaying it
            session.removeAttribute("message");
        }
    %>


    <section class="hero">
        <div class="hero-content">
            <h1>Your Ride, Your Way with MegaCab</h1>
            <p>Experience the most reliable and comfortable ride service in the city. MegaCab offers a variety of vehicles to suit your needs, from bikes to vans, all at affordable prices.</p>
            <div class="hero-buttons">
                <a href="#book-now" class="primary-btn">Book a Ride</a>
                <a href="../PAGES/About.jsp" class="secondary-btn">Learn More</a>
            </div>
        </div>
        <div class="hero-image">
            <img src="../IMG/girl-booked-online-taxi-from-app-illustration-download-in-svg-png-gif-file-formats--mobile-application-booking-car-pack-holidays-illustrations-4046977.webp" alt="MegaCab Booking Illustration">
        </div>
    </section>

    <section class="services">
        <div class="section-title">
            <h2>Our Services</h2>
            <p>Choose from our wide range of transportation options</p>
        </div>
        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-motorcycle"></i>
                </div>
                <h3>Bike</h3>
                <p>Perfect for quick trips and beating traffic. Our bike service gets you to your destination fast and affordably.</p>
            </div>
            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-tachometer-alt"></i>
                </div>
                <h3>Three-Wheeler</h3>
                <p>The traditional tuk-tuk experience with added comfort and reliability. Great for short to medium distances.</p>
            </div>
            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-shuttle-van"></i>
                </div>
                <h3>Van</h3>
                <p>Spacious and comfortable rides for groups or when you need extra space for luggage or goods.</p>
            </div>
        </div>
    </section>

    <section id="book-now" class="booking-section">
        <div class="book__container_main">
            <form id="initialForm" class="auth__form" action="<%=request.getContextPath()%>/BookingServlet" method="post">
                <div class="form-header">
                    <p>Request a ride</p>
                    <p>Price: <span id="priceDisplay">Select locations</span></p>
                </div>
                <select class="select" id="vehicleType" name="vehicleType" required>
                    <option value="" disabled selected>Select a vehicle type</option>
                    <option value="bike">Bike</option>
                    <option value="threewheeler">Three-Wheeler</option>
                    <option value="van">Van</option>
                </select>
                <input type="text" id="pickupLocation" name="pickupLocation" list="colomboLocations" placeholder="Pickup Location (e.g. Colombo Fort)" required>
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
                <input type="text" id="dropLocation" name="dropLocation" list="colomboLocations" placeholder="Drop Location (e.g. Colombo 7)" required>
                <input type="date" id="bookingDate" name="bookingDate" required>
                <input type="text" name="name" placeholder="Full Name" required>
                <input type="email" name="email" placeholder="Email Address" required>
                <input type="tel" name="phone" placeholder="Phone Number" required>
                <input type="text" name="nic" placeholder="NIC" required>
                <input class="auth__submit" type="submit" value="Book Vehicle">
                <input type="hidden" id="price" name="price" value="">

            </form>

            <div>
                <img height="500" src="../IMG/online-cab-booking-illustration-download-in-svg-png-gif-file-formats--order-taxi-app-service-pack-services-illustrations-3013176.webp" alt="MegaCab Booking">
            </div>
        </div>
    </section>

    <section class="features">
        <div class="section-title">
            <h2>Why Choose MegaCab?</h2>
            <p>We pride ourselves on providing the best transportation experience in town</p>
        </div>
        <div class="features-grid">
            <div class="feature">
                <div class="feature-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="feature-content">
                    <h3>Quick Pickups</h3>
                    <p>Our drivers are strategically positioned around the city to ensure you never have to wait long for your ride.</p>
                </div>
            </div>
            <div class="feature">
                <div class="feature-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <div class="feature-content">
                    <h3>Safety First</h3>
                    <p>All our drivers undergo rigorous background checks and training to ensure your safety is always the priority.</p>
                </div>
            </div>
            <div class="feature">
                <div class="feature-icon">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="feature-content">
                    <h3>Transparent Pricing</h3>
                    <p>No hidden charges or surge pricing. What you see is what you pay, with clear upfront pricing before every ride.</p>
                </div>
            </div>
            <div class="feature">
                <div class="feature-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="feature-content">
                    <h3>Rated Excellence</h3>
                    <p>Our service consistently receives high ratings from customers for comfort, reliability, and driver courtesy.</p>
                </div>
            </div>
            <div class="feature">
                <div class="feature-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <div class="feature-content">
                    <h3>24/7 Support</h3>
                    <p>Our customer service team is available round the clock to assist you with any queries or issues.</p>
                </div>
            </div>
            <div class="feature">
                <div class="feature-icon">
                    <i class="fas fa-hand-holding-heart"></i>
                </div>
                <div class="feature-content">
                    <h3>Loyalty Rewards</h3>
                    <p>Earn points with every ride and redeem them for discounts and free rides as part of our loyalty program.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="testimonials">
        <div class="testimonials-container">
            <div class="section-title">
                <h2>What Our Customers Say</h2>
                <p>Hear from people who have experienced our service</p>
            </div>
            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <div class="testimonial-content">
                        "MegaCab has completely changed how I commute to work. The bike service is quick and helps me avoid traffic. The drivers are always professional and on time."
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="author-info">
                            <h4>Rahul Perera</h4>
                            <p>Regular Customer</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-content">
                        "I use the three-wheeler service almost daily for shopping trips. The drivers are friendly, and I love how transparent the pricing is. No more haggling!"
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="author-info">
                            <h4>Amali Fernando</h4>
                            <p>Loyal Customer</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-card">
                    <div class="testimonial-content">
                        "The van service was perfect for our family trip. The vehicle was clean, the driver was courteous, and the booking process was seamless. Highly recommended!"
                    </div>
                    <div class="testimonial-author">
                        <div class="author-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="author-info">
                            <h4>Nisal Jayawardena</h4>
                            <p>Family Traveler</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="cta">
        <div class="cta-container">
            <h2>Ready for Your Next Ride?</h2>
            <p>Book now and experience the MegaCab difference. Whether you're heading to work, meeting friends, or exploring the city, we've got you covered.</p>
            <a href="#book-now" class="primary-btn">Book a Ride Now</a>
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
                    <h4>Services</h4>
                    <ul>
                        <li><a href="#">Bike Rides</a></li>
                        <li><a href="#">Three-Wheeler</a></li>
                        <li><a href="#">Van Booking</a></li>
                        <li><a href="#">Corporate Travel</a></li>
                        <li><a href="#">Airport Transfers</a></li>
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

    <script src="../VALIDATIONS/priceCalculate.js"></script>
    <script>

                document.addEventListener("DOMContentLoaded", function () {
                    const userDropdownBtn = document.getElementById("userDropdownBtn");
                    const bookingsDropdown = document.getElementById("bookingsDropdown");

                    // Hide dropdown initially
                    bookingsDropdown.style.display = "none";

                    // Toggle dropdown when clicking the user button
                    userDropdownBtn.addEventListener("click", function (event) {
                        event.stopPropagation();
                        if (bookingsDropdown.style.display === "none") {
                            bookingsDropdown.style.display = "block";
                        } else {
                            bookingsDropdown.style.display = "none";
                        }
                    });

                    // Close the dropdown if clicked outside
                    window.addEventListener("click", function (event) {
                        if (!event.target.closest("#userDropdownBtn") &&
                                !event.target.closest("#bookingsDropdown")) {
                            bookingsDropdown.style.display = "none";
                        }
                    });
                });
    </script>
</body>
</html>