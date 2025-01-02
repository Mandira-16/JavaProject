<%@page import="java.util.List"%>
<%@page import="cinema.model.Movie"%>
<%@page import="cinema.dao.MovieDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Theater Management</title>
        <style>
            /* General Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body and Background */
            body {
                font-family: Arial, sans-serif;
                background-color: #1a1a1a; /* Dark background */
                color: white; /* White color for all text */
                padding: 40px;
                overflow-x: hidden;
                transition: all 0.3s ease;
            }
            .container {
                display: flex;
                gap: 1rem; /* Space between left and right sections */

                border-radius: 8px;
                overflow: hidden;
            }
            .left {
                flex-basis: 20%; /* Takes 25% of the container width */
                padding: 1rem;

            }
            .right {
                flex-basis: 80%; 
                max-width: 1000px;
                margin: auto;
                padding: 30px;
                background-color: #333333;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.7);
            }

            header {
                text-align: center;
                margin-bottom: 40px;
            }

            header h1 {
                color: white;
                font-size: 30px; /* Increased font size */
                letter-spacing: 2px;
                font-weight: bold;
            }

            /* Search Bar */
            .search-bar {
                margin-bottom: 20px;
                display: flex;
                justify-content: center;
            }

            .search-bar input {
                width: 50%;
                padding: 18px; /* Increased padding */
                font-size: 18px; /* Increased font size */
                font-weight: bold;
                border-radius: 8px;
                border: 1px solid #888;
                background-color: #333;
                color: white;
            }

            /* Grid View */
            .movie-grid {
                margin-left: 250px;
                margin-top: 40px;
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px; /* Increased gap */
            }

            .movie-card {
                width: 250px;
                background-color: #444444;
                padding: 10px; /* Increased padding */
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.6);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }


            .movie-card img {
                width: 100%;
                height: 250px; /* Increased height */
                object-fit: cover;
                border-radius: 10px;
                margin-bottom: 15px;
            }



            .movie-card button {
                background-color: #b88b4a; /* Darker gold color */
                color: white;
                border: none;
                padding: 20px 40px; /* Larger padding */
                font-size: 24px; /* Increased font size */
                font-weight: bold; /* Bold text */
                border-radius: 10px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
                margin: 10px 0;
            }

            footer {
                text-align: center;
                margin-top: 40px;
                color: white;
                font-size: 16px; /* Larger font size */
            }

            /* Movie Form */
            .movie-form input,
            .movie-form textarea,
            .movie-form select{
                width: 100%;
                padding: 7px; /* Increased padding */
                margin: 12px 0;
                font-size: 17px; /* Increased font size */
                font-weight: bold;
                border: 1px solid #888;
                border-radius: 8px;
                background-color: #333;
                color: white;
                transition: all 0.3s ease;
            }

            .movie-form input:focus,
            .movie-form textarea:focus {
                border-color: #b88b4a; /* Dark gold focus */
                outline: none;
            }

            .movie-form button {
                background-color: #b88b4a;
                color: white;
                padding: 10px 10px; /* Increased padding */
                font-size: 15px; /* Larger font size */
                font-weight: bold; /* Bold text */
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
                margin: 15px 0;

            }

            .movie-form button:hover {
                background-color: #a1793b;
                transform: scale(1.1);
            }

            /* Image Upload */
            .image-upload {
                margin-bottom: 20px;
                font-weight: bold;
            }

            .image-upload input[type="file"] {
                background-color: #444;
                color: white;
                border: 1px solid #888;
                padding: 7px; /* Increased padding */
                font-size: 16px; /* Increased font size */
                border-radius: 8px;
                transition: background-color 0.3s ease;
            }

            .image-upload input[type="file"]:hover {
                background-color: #555;
            }
            .timeslot{
                display: flex;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="left">
                <jsp:include page="NavBar.jsp" />
            </div>
            <div class="right">
                <header>
                    <h1>Theater Management</h1>
                </header>
                <form id="movie-form" class="movie-form" action="insertShowServlet" method="post">
                    <label for="movie-id">Movie ID:</label>
                    <input
                        type="text"
                        id="movieId"
                        name="movieId"
                        required
                        /><br /><br />

                    <label for="hallNo">Hall No:</label>
                    <select id="hallNo" name="hallId">
                        <option value=""></option>
                        <option value="1">Marquee Hall</option>
                        <option value="2">Premiere Lounge</option>
                         <option value="3">Stardust Auditorium</option>
                    </select>

                    <label>Time Slots:</label>
                    <div class="timeslot">
                    <div>
                        <input type="checkbox" id="time1" name="showTime" value="10.00 AM">
                        <label for="time1">10.00 AM</label>
                    </div>
                    <div>
                        <input type="checkbox" id="time2" name="showTime" value="12.30 PM">
                        <label for="time2">12.30 PM</label>
                    </div>
                    <div>
                        <input type="checkbox" id="time3" name="showTime" value="3.30 PM">
                        <label for="time3">3.30 PM</label>
                    </div>
                         <div>
                        <input type="checkbox" id="time4" name="showTime" value="6.00 PM">
                        <label for="time3">6.00 PM</label>
                    </div>
                    </div>
                    <br /> <br />
                    <label for="startDate">Start Date:</label>
                    <input type="date" id="startDate" name="startDate"> <br /> <br />

                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" name="endDate"> 
                    <br /> <br />
                    <button type="submit">Save</button>
                    <button type="button">Cancel</button>
                </form>
            </div>
        </div>
        <!-- Footer -->
        <footer>
            <p>&copy; 2024 Filmor Cinema. All rights reserved.</p>
        </footer>



    </body>
</html>

