<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="cinema.model.Movie"%>
<%@page import="cinema.dao.MovieDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Movie Management</title>
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

            .movie-container{
                display: flex;
                margin:auto;
            }
            .table,th,td{
                text-transform: uppercase;
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
                    <h1>Movie Management</h1>
                </header>

                <h3>Add New Movie</h3>
                <form id="movie-form" class="movie-form" action="addMovie" method="post" enctype="multipart/form-data">
                    <label for="movie-id">Movie ID:</label>
                    <input
                        type="number"
                        id="movie-id"
                        name="movie-id"
                        required
                        /><br /><br />

                    <label for="movie-name">Movie Name:</label>
                    <input
                        type="text"
                        id="movie-name"
                        name="movie-name"
                        required
                        /><br /><br />

                    <label for="movie-language">Movie Language:</label>

                    <label for="movie-language">Select Language:</label>
                    <select id="movie-language" name="movie-language" required>
                        <option value="english">English</option>
                        <option value="hindi">Hindi</option>
                        <option value="tamil">Tamil</option>
                        <option value="telugu">Telugu</option>
                        <option value="malayalam">Malayalam</option>
                    </select>

                    <br /> <br />
                    <label for="movie-content">Movie Content:</label>
                    <textarea id="movie-content" name="movie-content" required></textarea><br /><br />

                    <label for="movie-trailer">Movie Trailer Link:</label>
                    <input
                        type="text"
                        id="movie-trailer"
                        name="movie-trailer"
                        required
                        /><br /><br />

                    <!-- Image Upload Section -->
                    <div class="image-upload">
                        <label for="movie-image">Upload Movie Flyer Image:</label>
                        <input
                            type="file"
                            id="movie-image"
                            name="movie-image"
                            accept="image/*"
                            onchange=""
                            required
                            /><br /><br />
                    </div>

                    <!-- Select Movie Status -->
                    <label for="movie-status">Movie Status:</label>
                    <select id="movie-status" name="movie-status" required>
                        <option value="now-showing">Now Showing</option>
                        <option value="coming-soon">Coming Soon</option></select
                    ><br /><br />
                    <label for="movie-ticket-price">Ticket Price</label>
                    <input
                        type="number"
                        id="movie-ticket-price"
                        name="movie-ticket-price"
                        required
                        /><br /><br /> 
                    <label for="movie-rated">R- Rated:</label>
                    <select id="movie-rated" name="movie-rated" required>
                        <option value="yes">Yes</option>
                        <option value="no">No</option></select
                    ><br /><br />
                    <button type="submit">Save Movie</button>
                    <button type="button">Cancel</button>
                </form>
            </div>

        </div>
        <div class="movie-grid" id="movie-grid">
            <div class="movie-container">
                <%
                    MovieDAO moviesDAO = new MovieDAO();
                    List<Movie> nowShowingMovies = moviesDAO.getMoviesByStatus("now-showing");
                    List<Movie> comingSoonMovies = moviesDAO.getMoviesByStatus("coming-soon");

                    // Combine the lists (if you need a single list for other processing)
                    List<Movie> allMovies = new ArrayList<>();
                    if (nowShowingMovies != null) {
                        allMovies.addAll(nowShowingMovies);
                    }
                    if (comingSoonMovies != null) {
                        allMovies.addAll(comingSoonMovies);
                    }

                    if (allMovies != null && !allMovies.isEmpty()) {
                %>
                <table style="width: 100%; color: white; border-collapse: collapse; text-align: left;">
                    <thead>
                        <tr style="background-color: #444;">
                            <th style="padding: 10px;">Image</th>
                            <th style="padding: 10px;">Name</th>
                            <th style="padding: 10px;">Language</th>
                            <th style="padding: 10px;">Status</th>
                            <th style="padding: 10px;">Price</th>
                            <th style="padding: 10px;">Rated</th>
                            <th style="padding: 10px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Movie movie : allMovies) {  // Iterate through the combined list allMovies
                        %>
                        <tr style="border-bottom: 1px solid #555;">
                            <td style="padding: 10px;">
                                <img src="<%= movie.getMovieImagePath()%>" alt="<%= movie.getMovieName()%>" style="width: 100px; height: 150px; object-fit: cover; border-radius: 5px;" />
                            </td>
                            <td style="padding: 10px;"><%= movie.getMovieName()%></td>
                            <td style="padding: 10px;"><%= movie.getMovieLanguage()%></td>
                            <td style="padding: 10px;"><%= movie.getMovieStatus()%></td>
                            <td style="padding: 10px;">LKR <%= movie.getMovieTicketPrice()%></td>
                            <td style="padding: 10px;"><%= movie.getMovieRate()%></td>
                            <td style="padding: 10px;">
                                <form style="display: inline;" action="updateMovie" method="post">
                                    <input type="hidden" name="movie-id" value="<%= movie.getMovieId()%>" />
                                    <button type="submit" style="background-color: #b88b4a; color: white; padding: 8px 16px; border: none; border-radius: 5px; cursor: pointer;">Update</button>
                                </form>
                                <form style="display: inline;" action="deleteMovie" method="post" onsubmit="return confirm('Are you sure you want to delete this movie?');">
                                    <input type="hidden" name="movie-id" value="<%= movie.getMovieId()%>" />
                                    <button type="submit" style="background-color: #d9534f; color: white; padding: 8px 16px; border: none; border-radius: 5px; cursor: pointer;">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <p>No movies available at the moment.</p>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            <p>&copy; 2024 Filmor Cinema. All rights reserved.</p>
        </footer>



    </body>
</html>

