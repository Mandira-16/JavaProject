<!DOCTYPE html>
<html lang="en">
    <head>
        <style>
            .para {
                gap: 25px;
                font-size: 15px;
                color: #000;
                border-radius: 8px;
                padding: 15px 10px;
                width: 280px;
                box-shadow: 0 3px 4px rgba(0, 0, 0, 0.2);
                text-align: center;
                background-color: white;
                margin: 15px;
            }

            .box {
                display: flex;
                gap: 20px;
                justify-content: center;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .para img {
                width: 50px;
                height: 50px;
                margin: 10px 0;
            }

            .para h3 {
                font-size: 18px;
                margin: 12px 0;
            }

            .para p {
                margin: 8px 0;
                font-size: 15px;
                line-height: 1.4;
            }

            .c-content {
                color: white;
                padding: 30px 0;
                background-color: #111;
                text-align: center;
            }

            .c-content h1 {
                font-size: 28px;
                margin-bottom: 15px;
                text-align: center;
            }

            .c-content > p {
                font-size: 16px;
                margin-bottom: 20px;
                text-align: center;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            footer {
                display: flex;
                justify-content: center;
                align-items: center;
                background-color: #030531;
                padding: 10px 0;
                margin-top: 20px;
                width: 100%;
                color: #FFFFFF;
            }

            footer p {
                margin: 0;
                font-size: 14px;
            }

            /* Add hover effect for social media links */
            .para a {
                color: #000;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .para a:hover {
                color: #f4b400;
            }

            .button-container {
                display: flex;
                justify-content: center;
                margin: 20px auto;
                width: 100%;
            }

            .feedback-button {
                background:  #ffad33;
                color: white;
                padding: 15px 30px;
                border-radius: 8px;
                text-decoration: none;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s;
                font-size: 1.2rem;
            }

            .feedback-button:hover {
                background: #e6992e;
            }
        </style>
    </head>
    <body>
        <div class="c-content">
            <h1>Get in touch</h1>
            <p>Want to get in touch? We would love to hear from you. Here is how you can reach us:</p>

            <div class="box">
                <div class="para">
                    <img src="images\call.jpeg" width="59" height="64">
                    <h3>For immediate support</h3>
                    <p>Please call our Customer Service Center:</p>
                    <p>Hotline: 011 2345678</p>
                </div>       


                <div class="para">
                    <img src="images\follow.jpg" width="59" height="64">
                    <h3>Follow us on</h3>
                    <p><a href="https://web.facebook.com/login/?_rdc=1&_rdr#">Facebook</a></p>
                    <p><a href="https://www.instagram.com/accounts/login/?hl=en">Instagram</a></p>
                    <p><a href="https://x.com/?&">X</a></p>
                </div>


                <div class="para">
                    <img src="images\chat.jpeg" width="59" height="64">
                    <h3>For further inquiries</h3>
                    <p>Email us at:</p>
                    <p>Email: filmorcinema1@gmail.com</p>
                </div>
            </div> 
            <div class="button-container">
                <form action="feedback.jsp" method="POST">
                    <button type="submit" class="feedback-button">Click to Share Your Valuable Feedback</button>
                </form>
            </div>
            <footer>
                <p>&copy; 2024 FILMOR 2024. All rights reserved &REG;</p>
            </footer>
        </div>
    </body>
</html>
