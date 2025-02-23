<%-- Document : Login Created on : Feb 3, 2025, 7:36:12 PM Author : Ashen Samarasekera --%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Login - Mega City Cab</title>
        <link rel="stylesheet" href="../STYLES/auth-styles.css" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;400;700&display=swap" rel="stylesheet" />
    </head>
    <body>
        <div class="errorMessage_login_cred" id="errorMessage" style="color: red;">
            <%
                String errorMessage = (String) session.getAttribute("errorMessage");
                if (errorMessage != null) {
                    out.println(errorMessage);
                    session.removeAttribute("errorMessage"); // Remove the message after displaying it
                    session.removeAttribute("username");
                    session.removeAttribute("role");
                }
            %>
        </div>


        <div class="main__container">
            <div class="auth__container">
                <form   action="<%=request.getContextPath()%>/LoginServlet" method="post" class="auth__form" id="authForm" >
                    <div class="auth__heading">
                        <div class="auth__topic">Sign In</div>
                        <div class="auth_sub">Hello, welcome back! Please log in to your account.</div>
                    </div>
                    <div class="auth__input">
                        <input type="text" placeholder="Username" id="username" name="username"  />
                        <div class="error" id="usernameError"></div>
                        <input type="password" placeholder="Password" id="password" name="password"  />
                        <div class="error" id="passwordError"></div>
                    </div>
                    <input class="auth__submit" type="submit" value="Sign In" />
                    <div class="auth__box">
                        <div>Don't have an account?</div>
                        <a href="../PAGES/Register.jsp">Sign Up</a>
                    </div>
                </form>
                <c:if test="${not empty errorMessage}">
                    <div class="error">${errorMessage}</div>
                </c:if>
            </div>
        </div>
        <script src="../VALIDATIONS/auth-validations.js"></script>
    </body>
</html>
