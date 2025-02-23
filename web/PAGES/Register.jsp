<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="../STYLES/auth-styles.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById("registerForm");
            const username = document.getElementById("username");
            const password = document.getElementById("password");
            const name = document.getElementById("name");
            const nic = document.getElementById("nic");
            const phoneNumber = document.getElementById("phone_number");
            const role = document.getElementById("role");
            const additionalFields = document.getElementById("additionalFields");

            function toggleAdditionalFields() {
                additionalFields.innerHTML = ""; // Clear previous fields

                if (role.value === "driver") {
                    additionalFields.innerHTML = `
                        <input  type='text' placeholder='License Number' id='license_number' name='license_number'  />
                        <div class="error" id="licenseError"></div>
                    `;
                    addInputListeners(document.getElementById("license_number"), "licenseError");
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

            function validateForm(event) {
                let isValid = true;

                isValid &= validateInput(username, "usernameError", "Username is required.");
                isValid &= validateInput(password, "passwordError", "Password is required.");
                isValid &= validateInput(name, "nameError", "Name is required.");
                isValid &= validateInput(nic, "nicError", "NIC is required.");
                isValid &= validateInput(phoneNumber, "phoneError", "Phone number is required.");

                if (role.value === "driver") {
                    const licenseNumber = document.getElementById("license_number");
                    if (licenseNumber) {
                        isValid &= validateInput(licenseNumber, "licenseError", "License number is required.");
                    }
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

            form.addEventListener("submit", validateForm);
        });
    </script>
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

                    <input type="password" placeholder='Password' id="password" name="password" />
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
                    <div>Don't have an account?</div>
                    <a href="../PAGES/Login.jsp">Sign In</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
