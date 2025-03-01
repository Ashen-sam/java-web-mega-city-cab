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
                        <select id="gender" name="gender" class="select" required>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                        <div class="error" id="genderError"></div>

                        <input type='text' placeholder='Address' id='address' name='address' />
                        <div class="error" id="addressError"></div>

                        <input type='date' placeholder='License Expiry Date' id='license_expiry_date' name='license_expiry_date' />
                        <div class="error" id="licenseExpiryError"></div>

                        <input type='number' placeholder='Driving Experience (Years)' id='driving_experience' name='driving_experience' />
                        <div class="error" id="drivingExperienceError"></div>

                        <input type='text' placeholder='Vehicle Type' id='vehicle_type' name='vehicle_type' />
                        <div class="error" id="vehicleTypeError"></div>

                        <input type='text' placeholder='Vehicle Registration Number' id='vehicle_registration_number' name='vehicle_registration_number' />
                        <div class="error" id="vehicleRegError"></div>

                        <input type='text' placeholder='Vehicle Make and Model' id='vehicle_make_model' name='vehicle_make_model' />
                        <div class="error" id="vehicleMakeModelError"></div>
                    `;

                    // Add input listeners for new fields
                    addInputListeners(document.getElementById("gender"), "genderError");
                    addInputListeners(document.getElementById("address"), "addressError");
                    addInputListeners(document.getElementById("license_expiry_date"), "licenseExpiryError");
                    addInputListeners(document.getElementById("driving_experience"), "drivingExperienceError");
                    addInputListeners(document.getElementById("vehicle_type"), "vehicleTypeError");
                    addInputListeners(document.getElementById("vehicle_registration_number"), "vehicleRegError");
                    addInputListeners(document.getElementById("vehicle_make_model"), "vehicleMakeModelError");
                }
            }

            role.addEventListener("change", toggleAdditionalFields);

            function validateInput(inputElement, errorElementId, errorMessage) {
                const errorElement = document.getElementById(errorElementId);
                if (inputElement.value.trim() === "") {
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

                isValid &= validateInput(username, "usernameError", "Username is required.");
                isValid &= validatePassword();
                isValid &= validateInput(name, "nameError", "Name is required.");
                isValid &= validateInput(nic, "nicError", "NIC is required.");
                isValid &= validateInput(phoneNumber, "phoneError", "Phone number is required.");

                if (role.value === "driver") {
                    isValid &= validateInput(document.getElementById("gender"), "genderError", "Gender is required.");
                    isValid &= validateInput(document.getElementById("address"), "addressError", "Address is required.");
                    isValid &= validateInput(document.getElementById("license_expiry_date"), "licenseExpiryError", "License expiry date is required.");
                    isValid &= validateInput(document.getElementById("driving_experience"), "drivingExperienceError", "Driving experience is required.");
                    isValid &= validateInput(document.getElementById("vehicle_type"), "vehicleTypeError", "Vehicle type is required.");
                    isValid &= validateInput(document.getElementById("vehicle_registration_number"), "vehicleRegError", "Vehicle registration number is required.");
                    isValid &= validateInput(document.getElementById("vehicle_make_model"), "vehicleMakeModelError", "Vehicle make and model is required.");
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

            // Attach listeners to all input fields for real-time validation removal
            addInputListeners(username, "usernameError");
            addInputListeners(password, "passwordError");
            addInputListeners(name, "nameError");
            addInputListeners(nic, "nicError");
            addInputListeners(phoneNumber, "phoneError");

            password.addEventListener("input", validatePassword);
            form.addEventListener("submit", validateForm);

            // Show/Hide Password Toggle
            togglePassword.addEventListener("click", function () {
                if (password.type === "password") {
                    password.type = "text";
                    togglePassword.innerHTML = "&#128065;"; // Eye icon (👁)
                } else {
                    password.type = "password";
                    togglePassword.innerHTML = "&#128064;"; // Closed eye (👁‍🗨)
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