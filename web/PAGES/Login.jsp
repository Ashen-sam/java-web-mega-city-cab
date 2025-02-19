<%-- Document : Login Created on : Feb 3, 2025, 7:36:12 PM Author : Ashen
Samarasekera --%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>JSP Page</title>
    <link rel="stylesheet" href="../STYLES/auth-styles.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <div class="main__container">
      <div class="auth__container">
        <form action="action" class="auth__form" id="authForm">
          <div class="auth__heading">
            <div class="auth__topic">Sign In</div>
            <div class="auth_sub">
              Hello, welcome back to your account welcome <br />
              back to your accountwelcome back account welcome back
            </div>
          </div>
          <div class="auth__input">
            <input
              type="text"
              placeholder="username"
              id="username"
              name="username"
            />
            <div class="error" id="usernameError"></div>
            <input
              type="password"
              placeholder="password"
              id="password"
              name="password"
            />
            <div class="error" id="passwordError"></div>
          </div>
          <input class="auth__submit" type="submit" value="Sign in" />
          <div class="auth__box">
            <div>Create an account</div>
            <a href="../PAGES/Register.jsp">Sign up</a>
          </div>
        </form>
      </div>
    </div>
    <script src="../VALIDATIONS/auth-validations.js"></script>
  </body>
</html>
