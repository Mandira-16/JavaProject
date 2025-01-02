<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Filmor Cinema About Us</title>
        <style>
            body {
                background-color: black;
                margin: 0;
                font-family: Arial, sans-serif;
            }

            h1 {
                color: #ffad33;
                text-align: left;
            }

            h2 {
                color: white;
                font-size: 18px;
                line-height: 1.6;
            }

            h3 {
                color: white;
                font-size: 24px;
            }
            .Intro{
                color: white;
                font-size: 16px;
                line-height: 1.6;
            }

            .container {
                max-width: 1000px;
                margin: 20px auto;
                padding: 40px;
                background-color: #383838;
                border-radius: 8px;
            }

            .team-container {
                display: flex;
                overflow-x: auto; 
                gap: 20px;
                padding: 10px 0;
                scrollbar-width: none; 
            }
            .award-container{
                display: flex;
                overflow-x: auto; 
                gap: 35px;
                padding: 45px 20px;
                scrollbar-width: none; 
            }

            .team-container::-webkit-scrollbar,
            .award-container::-webkit-scrollbar {
                display: none;
                transform: scale(0.8);

            }

            .award-member:hover{
                transform: scale(1.15);
                transition: opacity 0.5s, transform 0.5s; 
                border-radius: 10%;
            }
            .team-member, .award-member {
                min-width: 200px;
                text-align: center;
                background-color: #2b2b2b;
                padding: 20px;
                border-radius: 8px;
            }

            .team-member h4, .award-member h4 {
                color: white;
                font-size: 18px;
                margin-bottom: 5px;
            }

            .team-member p, .award-member p {
                color: #aaa;
                font-size: 14px;
                margin-top: 5px;
            }

            .team-member img, .award-member img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <img src= "images\Seats_Hall.jpg" alt="Hall" width=100% height=450px>
        <div class="container">
            <h1>About Us</h1>
            <h2>Welcome to Filmor Cinema!</h2>
            <p class="Intro">We are committed to providing an exceptional movie-going experience with state-of-the-art technology and unmatched comfort. At Filmor, we believe that every movie is a journey, and we are here to ensure yours is unforgettable. Our cinemas are equipped with cutting-edge projection systems, including 4K resolution and immersive 3D technology, paired with advanced surround sound to bring every frame and note to life. Whether it’s the heart-pounding action, spine-tingling thrillers, or the soulful melodies of musicals, we promise to deliver every story as the creators intended. 
                <br><br>At the heart of Filmor Cinema is your comfort. From plush recliner seating to personalized snack services, we aim to make your time with us as relaxing as it is entertaining. Indulge in our wide variety of gourmet snacks and beverages, freshly prepared to elevate your movie-watching experience. Beyond movies, we’re proud to host live screenings, exclusive premieres, and community events that celebrate the art of cinema. Our passion for films extends to nurturing local talent and bringing international masterpieces to our screens.  
                <br><br>Step into Filmor Cinema, where stories come alive, connections are made, and every visit is a cherished memory. Your ultimate cinematic adventure awaits!</p>  
        </div>

        <br><br>

        <div class="container">
            <h1>TEAM</h1>
            <div class="team-container">
                <div class="team-member">
                    <img src="images\girl3.jpg" alt="Mandira">
                    <h4>Mandira De Silva</h4>
                    <p>Director</p>
                </div>
                <div class="team-member">
                    <img src="images\boy1.jpg" alt="Senesh">
                    <h4>Senesh Fitzroy</h4>
                    <p>Manager</p>
                </div>
                <div class="team-member">
                    <img src="images\girl1.jpg" alt="Kavindini">
                    <h4>Kavidini Kinkini</h4>
                    <p>Producer</p>
                </div>
                <div class="team-member">
                    <img src="images\boy2.jpg" alt="Milhara">
                    <h4>Milhara Bhagya</h4>
                    <p>Assistant Director</p>
                </div>
                <div class="team-member">
                    <img src="images\girl2.jpg" alt="Shwetha">
                    <h4>Shwetha Mandakini</h4>
                    <p>Screenwriter</p>
                </div>
                <div class="team-member">
                    <img src="images\girl4.jpg" alt="Isidara">
                    <h4>Isidara Charuni</h4>
                    <p>Editor</p>
                </div>
                <div class="team-member">
                    <img src="images\girl5.jpg" alt="Tracey">
                    <h4>Tracey Paul</h4>
                    <p>Sound Engineer</p>
                </div>
                <div class="team-member">
                    <img src="images\girl6.jpg" alt="Deepthi">
                    <h4>Deepthi Mandira</h4>
                    <p>Art Director</p>
                </div>
            </div>
        </div>

        <!-- Awards Section with Spotlight -->
        <div class="container">
            <h1>AWARDS</h1>
            <div class="award-container" id="awardContainer">
                <div class="award-member">
                    <img src="images\award2.jpg" alt="Award 1">
                    <h4>2020</h4>
                    <p>Cinematic Excellence Award</p>
                    <p>Recognized for delivering outstanding experiences in cinema technology and customer satisfaction.</p>
                </div>
                <div class="award-member">
                    <img src="images\award1.jpg" alt="Award 2">
                    <h4>2021</h4>
                    <p>Best Innovative Cinema Chain</p>
                    <p>Awarded for introducing cutting-edge technology and redefining movie-going comfort and convenience.</p>
                </div>
                <div class="award-member">
                    <img src="images\award3.jpg" alt="Award 3">
                    <h4>2022</h4>
                    <p>Most Trusted Cinema Brand</p>
                    <p>Earned the trust of millions for consistently delivering exceptional service and entertainment.</p>
                </div>
                <div class="award-member">
                    <img src="images\award4.jpg" alt="Award 4">
                    <h4>2022</h4>
                    <p>Leader in Luxury Cinematic Experience</p>
                    <p>Honored for redefining luxury with premium seating, gourmet dining, and immersive audio-visual experiences.</p>
                </div>
                <div class="award-member">
                    <img src="images\award5.jpg" alt="Award 5">
                    <h4>2023</h4>
                    <p>Customer Choice Award</p>
                    <p>Voted the favorite cinema by audiences for unparalleled service and memorable movie moments.</p>
                </div>
                <div class="award-member">
                    <img src="images\Entertainment.webp" alt="Award 6">
                    <h4>2023</h4>
                    <p>Excellence in Entertainment Innovation</p>
                    <p>Awarded for pioneering advancements in cinematic technology and delivering immersive entertainment experiences.</p>
                </div>
                <div class="award-member">
                    <img src="images\Sustainability.webp" alt="Award 7">
                    <h4>2024</h4>
                    <p>Sustainability in Cinema Award</p>
                    <p>Recognized for leading efforts in eco-friendly cinema practices, including energy-efficient theaters and waste reduction initiatives.</p>
                </div>
                <div class="award-member">
                    <img src="images\award6.jpg" alt="Award 8">
                    <h4>2024</h4>
                    <p>Best Community Engagement Initiative</p>
                    <p>Honored for fostering connections with the community through exclusive screenings, charity events, and support for local filmmakers.</p>
                </div>
            </div>
        </div>

    </body>
</html>
