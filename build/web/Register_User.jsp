<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
      body {
        background-image: url("images/Login_Background.jpg");
        background-size: cover;
        background-position: center center;
        background-attachment: fixed;
      }

      .login-container {
        background-color: rgba(0, 0, 0, 0.6);
        border-radius: 10px;
        padding: 30px;
        color: white;
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
      }
      .form-label {
        font-weight: bold;
        color: #ffc107;
      }

      .form-control:focus {
        border-color: #ffc107;
        box-shadow: 0 0 5px rgba(255, 193, 7, 0.8);
      }

      .btn-warning {
        background-color: #ffc107;
        border: none;
        transition: all 0.3s ease-in-out;
      }

      .btn-warning:hover {
        background-color: #e0a800;
      }

      .btn-outline-warning {
        color: #ffc107;
        border-color: #ffc107;
      }

      .btn-outline-warning:hover {
        background-color: #ffc107;
        color: #212529;
      }

      a {
        color: #ffc107;
      }

      a:hover {
        color: #e0a800;
        text-decoration: underline;
      }
      .image{
          margin: 15px;
      }
    </style>
  </head>
  <body>
    <div class="image">
          <img src="images\Filmor Logo.jpg" width="150" heigth="auto" alt="Icon" />
    </div>
    <!-- Registration Form -->
    <div class="container">
      <div class="row justify-content-center align-items-center vh-100"  style="margin-top: -120px;">
        <div class="col-md-8 col-lg-6">
          <div class="login-container">
            <h2 class="text-center mb-4">Registration</h2>
            <form action="register" method="POST">
              <div class="row mb-3">
                <div class="col-md-6">
                  <label for="first-name" class="form-label">First Name</label>
                  <input type="text" class="form-control" id="first-name"  name="first-name" placeholder="Enter first name">
                </div>
                <div class="col-md-6">
                  <label for="last-name" class="form-label">Last Name</label>
                  <input type="text" class="form-control" id="last-name" name="last-name" placeholder="Enter last name">
                </div>
              </div>
              <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email address">
              </div>
              <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="tel" class="form-control" id="phone" name="phoneno" placeholder="Enter phone number">
              </div>
              <div class="row mb-3">
                <div class="col-md-6">
                  <label for="password" class="form-label">Password</label>
                  <input type="password" class="form-control" id="password" name="password" placeholder="Enter password">
                </div>
                <div class="col-md-6">
                  <label for="confirm-password" class="form-label">Confirm Password</label>
                  <input type="password" class="form-control" id="confirm-password" name="confirm-password" placeholder="Confirm password">
                </div>
              </div>
              <div class="text-center">
                <button type="submit" class="btn btn-warning btn-lg w-100" >CREATE</button>
              </div>
              <div class="text-center mt-4">
                <p>Already have an account? <a href="Login.jsp">LOGIN</a></p>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <!-- Footer -->
        <footer>
            <p align="center"><font color="white">&copy; 2024 Filmor Cinema. All rights reserved &REG;</font></p>
        </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  </body>
</html>


