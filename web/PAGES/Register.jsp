<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register - Mega City Cab</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css"/>

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />

        <style>
            .alert-message {
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                border: 2px solid #28a745;
                background-color: #d4edda;
                color: #155724;
                padding: 10px;
                border-radius: 5px;
                font-weight: bold;
            }
        </style>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("registerForm");
                const username = document.getElementById("username");
                const password = document.getElementById("password");
                const togglePassword = document.getElementById("togglePassword");
                const name = document.getElementById("name");
                const nic = document.getElementById("nic");
                const phoneNumber = document.getElementById("phone_number");
                const role = document.getElementById("role");
                const additionalFields = document.getElementById("additionalFields");

                function toggleAdditionalFields() {
                    additionalFields.innerHTML = ""; // Clear previous fields

                    if (role.value === "driver") {
                        additionalFields.innerHTML = `
                    <select style='width:400px' id="gender" name="gender" class="select" required>
                        <option value="">Select Gender</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                    <div class="error" id="genderError"></div>

                    <input style='width:370px'  type='text' placeholder='Address' id='address' name='address' />
                    <div class="error" id="addressError"></div>

                    <input  style='width:370px'  type='text' placeholder='License Number' id='license_number' name='license_number' />
                    <div class="error" id="license_numberError"></div>
                  
   <select style='width:400px' id="vehicle_type" name="vehicle_type" class="select" required>
                        <option value="Bike">Bike</option>
                        <option value="Car">Car</option>
                        <option value="Van">Van</option>
                        <option value="Three_Wheeler">Three Wheeler</option>
                    </select>
                                <div class="error" id="vehicleTypeError"></div>

                    <input  style='width:370px'  type='text' placeholder='Vehicle Registration Number' id='vehicle_registration_number' name='vehicle_registration_number' />
                    <div class="error" id="vehicleRegError"></div>

                    <input  style='width:370px'  type='text' placeholder='Vehicle Make and Model' id='vehicle_make_model' name='vehicle_make_model' />
                    <div class="error" id="vehicleMakeModelError"></div>
                `;

                        document.querySelectorAll("#additionalFields input, #additionalFields select").forEach(input => {
                            addInputListeners(input, input.id + "Error");
                        });
                    }
                }

                role.addEventListener("change", toggleAdditionalFields);
                toggleAdditionalFields(); // Ensure fields appear correctly on page load

                function validateInput(inputElement, errorElementId, errorMessage) {
                    const errorElement = document.getElementById(errorElementId);
                    if (!inputElement || inputElement.value.trim() === "") {
                        errorElement.textContent = errorMessage;
                        return false;
                    } else {
                        errorElement.textContent = "";
                        return true;
                    }
                }

                function validatePassword() {
                    const errorElement = document.getElementById("passwordError");
                    if (password.value.length < 8) {
                        errorElement.textContent = "Password must be at least 8 characters.";
                        return false;
                    } else {
                        errorElement.textContent = "";
                        return true;
                    }
                }

                function validateForm(event) {
                    let isValid = true;

                    isValid = validateInput(username, "usernameError", "Username is required.") && isValid;
                    isValid = validatePassword() && isValid;
                    isValid = validateInput(name, "nameError", "Name is required.") && isValid;
                    isValid = validateInput(nic, "nicError", "NIC is required.") && isValid;
                    isValid = validateInput(phoneNumber, "phoneError", "Phone number is required.") && isValid;

                    if (role.value === "driver") {
                        isValid = validateInput(document.getElementById("gender"), "genderError", "Gender is required.") && isValid;
                        isValid = validateInput(document.getElementById("address"), "addressError", "Address is required.") && isValid;
                        isValid = validateInput(document.getElementById("license_number"), "license_numberError", "License number is required.") && isValid;
                        isValid = validateInput(document.getElementById("vehicle_type"), "vehicleTypeError", "Vehicle type is required.") && isValid;
                        isValid = validateInput(document.getElementById("vehicle_registration_number"), "vehicleRegError", "Vehicle registration number is required.") && isValid;
                        isValid = validateInput(document.getElementById("vehicle_make_model"), "vehicleMakeModelError", "Vehicle make and model is required.") && isValid;
                    }

                    if (!isValid) {
                        event.preventDefault(); // Stop form submission if invalid
                    }
                }

                function addInputListeners(inputElement, errorElementId) {
                    inputElement.addEventListener("input", function () {
                        document.getElementById(errorElementId).textContent = "";
                    });
                }

                addInputListeners(username, "usernameError");
                addInputListeners(password, "passwordError");
                addInputListeners(name, "nameError");
                addInputListeners(nic, "nicError");
                addInputListeners(phoneNumber, "phoneError");

                password.addEventListener("input", validatePassword);
                form.addEventListener("submit", validateForm);

                togglePassword.addEventListener("click", function () {
                    if (password.type === "password") {
                        password.type = "text";
                        togglePassword.innerHTML = "&#128065;";
                    } else {
                        password.type = "password";
                        togglePassword.innerHTML = "&#128064;";
                    }
                });
            });

        </script>
        <style>
            .password-container {
                position: relative;
                width: 100%;
            }
            .password-container input {
                width: 345px;
                padding-right: 40px; /* Space for icon */
            }
            .toggle-password {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                font-size: 18px;
            }
        </style>
    </head>
    <body>
        <% if (session.getAttribute("errorMessage") != null) {%>
        <div class="alert-message" id="errorMessage" style=" margin-bottom: 15px; text-align: center;">
            <%= session.getAttribute("errorMessage")%>
        </div>
        <% session.removeAttribute("errorMessage"); %>
        <% }%>
        <div class="main__container">

            <div class='auth__container'>

                <form action="<%=request.getContextPath()%>/RegisterServlet" method="post" class="auth__form" id="registerForm">
                    <div class="auth__heading">
                        <div class="auth__topic">Sign Up</div>
                    </div>
                    <div class="auth__input">
                        <select id="role" name="role" class="select" required>
                            <option value="customer">Customer</option>
                            <option value="driver">Driver</option>
                        </select>
                        <input type='text' placeholder='Username' id="username" name="username" />
                        <div class="error" id="usernameError"></div>

                        <div class="password-container">
                            <input type="password" placeholder='Password' id="password" name="password" />
                            <span id="togglePassword" class="toggle-password">&#128064;</span>
                        </div>
                        <div class="error" id="passwordError"></div>

                        <input type='text' placeholder='Name' id="name" name="name" />
                        <div class="error" id="nameError"></div>

                        <input type='text' placeholder='NIC' id="nic" name="nic" />
                        <div class="error" id="nicError"></div>

                        <input type='text' placeholder='Phone Number' id="phone_number" name="phone_number" />
                        <div class="error" id="phoneError"></div>

                        <div id="additionalFields"></div>
                    </div>
                    <input class='auth__submit' type='submit' value='Sign up'/>
                    <div class="auth__box">
                        <div>Already have an account?</div>
                        <a href="../PAGES/Login.jsp">Sign In</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>