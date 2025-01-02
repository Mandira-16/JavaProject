<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
    </head>
    <body>
        <style>
            body {
                background-image: url(images/Login_Background.jpg);
                background-size: cover;
                background-position: center center;
                background-attachment: fixed;
            }
            .login-container {
                background-color: rgba(0, 0, 0, 0.6);
                border-radius: 10px;
                padding: 40px;
                color: white;
            }
        </style>
        <div class="container vh-100 d-flex justify-content-center align-items-center">
            <div class="login-container">
                <div class="text-center">
                    <img src="images\Filmor Logo.jpg" class="rounded" height="100" width="100" alt="Icon">
                </div>
                <h3 class="text-center mt-3">LOGIN</h3>
                <hr class="text-white">
                <form action="user-login" method="post">
                    <div class="input-group mb-3">
                        <span class="input-group-text bg-warning border border-warning">
                            <i class="bi bi-person"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Email" name="email">
                    </div>
                    <div class="input-group mb-3">
                        <span class="input-group-text bg-warning border border-warning">
                            <i class="bi bi-key"></i>
                        </span>
                        <input type="password" class="form-control" placeholder="Password" name="password">
                    </div>
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-warning w-100">Login</button>
                    </div>
                </form>
                <hr class="text-white">
                <div class="text-center">
                    <a href="#" class="text-decoration-none text-warning">Forgot Password?</a><br>
                    Not registered? <a href="Register_User.jsp" class="text-decoration-none text-warning">Create an account</a>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>

