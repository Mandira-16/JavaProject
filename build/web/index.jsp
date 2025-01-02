<%@page import="java.util.List"%>
<%@page import="cinema.model.Movie"%>
<%@page import="cinema.dao.MovieDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Filmor Cinema</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0px;
                padding: 0;
                background-color: #111;
                color: white;
            }
            header {
                background-color: black;
                padding:1rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            header img {
                height: 100px;
                margin-left:10px;
            }
            header input {
                background-color: transparent;
                border: 1px solid #555;
                padding: 0.5rem;
                color: white;
                outline: none;
                border-radius: 4px;
                margin-left: auto;
                margin-right: 10px;
            }
            .menu-icon {
                background-color: transparent;
                border: none;
                color: white;
                font-size: 1.5rem;
                cursor: pointer;
                margin-left: 20px;
            }

            .menu-icon span {
                display: block;
            }

            .menu-icon:hover {
                color: #f4b400;
            }

            .banner {
                position: relative;
                height: 60vh;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                background: none; /* Remove the gradient overlay */
            }

            .carousel {
                position: relative;
                width: 80%;
                height: 100%;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                background-size: cover;
                background-position: center;
            }

            .carousel::before {
                content: '';
                position: absolute;
                inset: -20px; /* Negative margin to ensure no edges */
                background: inherit;
                background-size: cover;
                background-position: center;
                filter: blur(20px) brightness(0.7);
                z-index: 0;
            }

            .carousel img {
                position: relative;
                width: auto;
                height: 100%;
                max-width: 100%;
                object-fit: fill;
                display: none;
                z-index: 1;
            }

            .carousel img.active {
                display: block;
            }

            /*Navigation controls*/
            .carousel-controls{
                position: absolute;
                top:50%;
                width:100%;
                display:flex;
                justify-content: space-between;
                transform: translateY(-50%);
                z-index: 10; /*Ensure controls stay on top*/
            }
            .carousel-controls button {
                background-color: rgba(0,0,0,0.5);/*semi transparent background*/
                color:white;
                border:none;
                font-size: 2rem;
                padding: 0.5rem 1rem;
                cursor: pointer;
                border-radius: 50%;
                transition: background-color 0.3s ease;
            }
            .carousel-controls button:hover {
                background-color: rgba(255, 255, 255, 0.8);
                color: black;
            }

            .section-title {
                margin: 2rem 1rem;
                font-size: 1.8rem;
                text-align: left;
            }

            .movie-container {
                display: grid;
                gap: 1rem;
                padding:1rem;
                max-width: 1600px;
                margin: 0 auto;
            }

            .now-showing .movie-container,
            .coming-soon .movie-container {
                grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            }

            .movie-card {
                background-color: #222;
                border-radius: 5px;
                overflow: hidden;
                text-align: center;
                padding: 0 0.5rem;
                transition: transform 0.3s;
                max-width: 400px;
                margin: 0 auto;
            }

            .movie-card img:hover {
                transform: scale(1.1);
                transition: opacity 0.5s, transform 0.5s; /* Smooth transition */
            }

            .movie-card img {
                width: 100%;
                height: 500px;
                object-fit: contain;
                margin-bottom: 1rem;
                transition: transform 0.3s;
            }

            .movie-card h3 {
                margin: 1rem 0;
                font-size: 1.6rem;  /* Increased from 1.2rem */
                font-weight: bold;  /* Added to make it more prominent */
                line-height: 1.3;   /* Added for better readability if title wraps */
                padding: 0 0.5rem;  /* Added padding for titles that might run long */
            }

            .movie-card p {
                font-size: 1.1rem;
                color: #bbb;
                margin: 0.5rem 0;
                text-transform: uppercase;
            }

            .movie-card button {
                background-color: #f4b400;
                border: none;
                padding: 0.5rem 1rem;
                margin: 0.5rem 0;
                color: black;
                border-radius: 4px;
                cursor: pointer;
                text-transform: uppercase;
            }

            .movie-card button:hover {
                background-color: #d49e00;
            }
            /* Dropdown Button */
            .dropdown {
                position: relative;
                display: inline-block;
                margin-right: 90px;
            }

            .menu-icon {
                background-color: transparent;
                color: white;
                border: none;
                font-size: 18px;
                cursor: pointer;
            }

            .menu-icon:hover {
                color: #f4b400;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .menu-icon {
                background-color: transparent;
                color: white;
                border: none;
                font-size: 1.5rem;
                cursor: pointer;
            }

            .menu-icon:hover {
                color: #f4b400;
            }

            .modal {
                display: none;
                position: absolute;
                z-index: 1;
                left: 50%;
                top: 50%;
                transform: translate(-50%,-50%);
                width: 100%;
                height: 100%;
                overflow: auto;
            }

            .modal-content {
                width: 80%;
                max-width: 800px;
                max-height: 80%;
                overflow-y: auto;
                position: absolute;
                z-index: 1;
                left: 50%;
                top: 50%;
                transform: translate(-50%,-50%);
                background-color: #333;
                border-radius: 10px;
                padding: 1rem;
            }

            .video-container {
                position: relative;
                width: 100%;
                padding-bottom: 56.25%; /* 16:9 aspect ratio */
            }

            .video-container iframe {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: black;
                color: white;
                min-width: 160px;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1;
                border-radius: 5px;
                overflow: hidden;
            }

            .dropdown-content a {
                color: white;
                padding: 10px 15px;
                text-decoration: none;
                display: block;
                transition: background-color 0.2s;
            }

            .dropdown-content a:hover {
                background-color: #f4b400;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }
        </style>
    </head>
    <body>

        <header>
            <img src="images/Filmor Logo.jpg" alt="Filmor Logo">
            <input type="text" placeholder="Search...">
            <!-- Dropdown Button -->
            <div class="dropdown">
                <button class="menu-icon" type="button">
                    <span>&#9776;</span>
                </button>
                <div class="dropdown-content">
                    <a href="Login.jsp">Login</a>
                    <a href="AboutUs.jsp">About Us</a>
                </div>
            </div>
        </header>
        <%
            MovieDAO moviesDAO = new MovieDAO();  // Create ONE instance of moviesDAO
            List<Movie> nowShowingMovies = moviesDAO.getMoviesByStatus("now-showing");
            List<Movie> comingSoonMovies = moviesDAO.getMoviesByStatus("coming-soon"); //Get coming soon movies here

        %> 
        <div class="banner">
            <div class="carousel">
                <%                if (nowShowingMovies != null && !nowShowingMovies.isEmpty()) {
                        for (int i = 0; i < nowShowingMovies.size(); i++) {
                            Movie movie = nowShowingMovies.get(i);
                %>
                <img src="<%= movie.getMovieImagePath()%>" alt="<%= movie.getMovieName()%>" class="<%= i == 0 ? "active" : ""%>"> 
                <%
                        }
                    }
                %>
            </div>
            <div class="carousel-controls">
                <button id="prevBtn"><</button>
                <button id="nextBtn">></button>
            </div>
        </div>


        <script>
            const carousel = document.querySelector('.carousel');
            const images = carousel.querySelectorAll('img');
            let currentIndex = 0;

            const nextBtn = document.getElementById('nextBtn');
            const prevBtn = document.getElementById('prevBtn');

            function showImage(index) {
                images.forEach((img, i) => {
                    img.classList.toggle('active', i === index);
                    if (i === index) {
                        carousel.style.backgroundImage = `url('${img.src}')`;
                    }
                });
            }

// Initialize first image
            showImage(currentIndex);

            nextBtn.addEventListener('click', () => {
                currentIndex = (currentIndex + 1) % images.length;
                showImage(currentIndex);
            });

            prevBtn.addEventListener('click', () => {
                currentIndex = (currentIndex - 1 + images.length) % images.length;
                showImage(currentIndex);
            });

// Auto-rotate
            setInterval(() => {
                currentIndex = (currentIndex + 1) % images.length;
                showImage(currentIndex);
            }, 3000);

        </script>

        <div class="now-showing">
            <h2 class="section-title">Now Showing</h2>
            <div class="movie-container">
                <%
                    if (nowShowingMovies != null && !nowShowingMovies.isEmpty()) {
                        for (Movie movie : nowShowingMovies) { // Use the already fetched nowShowingMovies list
%>
                <div class="movie-card">
                    <img src="<%= movie.getMovieImagePath()%>" alt="<%= movie.getMovieName()%>">
                    <h3><%= movie.getMovieName()%></h3>
                    <p><%= movie.getMovieLanguage()%></p>
                    <button onclick="location.href = 'MovieDatailsServlet?movieId=<%= movie.getMovieId()%>'">Book Now</button>
                    <button class="trailer-btn" data-trailer-link="<%= movie.getMovieTrailerLink()%>">Trailer</button>
                </div>

                <%      }
                } else {
                %>
                <p>No movies available at the moment.</p>
                <%
                    }
                %>

            </div>
        </div>
        <!-- Modal -->
        <div id="trailer-modal" class="modal">
            <div class="modal-content">
                <span class="close-button">&times;</span>
                <div class="video-container">
                    <iframe 
                        width="1200" 
                        height="600" 
                        src="" 
                        title="YouTube video player" 
                        frameborder="0" 
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                        allowfullscreen>
                    </iframe>
                </div>
            </div>
        </div>

        <div class="coming-soon"> <%-- Coming Soon Section --%>
            <h2 class="section-title">Coming Soon</h2>
            <div class="movie-container">
                <%
                    if (comingSoonMovies != null && !comingSoonMovies.isEmpty()) {
                        for (Movie movie : comingSoonMovies) {
                %>
                <div class="movie-card">
                    <img src="<%= movie.getMovieImagePath()%>" alt="<%= movie.getMovieName()%>">
                    <h3><%= movie.getMovieName()%></h3>
                    <p><%= movie.getMovieLanguage()%></p>
                    <button class="trailer-btn" data-trailer-link="<%= movie.getMovieTrailerLink()%>">Trailer</button>
                </div>
                <%
                    }
                } else {
                %>
                <p>No upcoming movies available at the moment.</p>
                <%
                    }
                %>
            </div>
        </div>
        <script>
            // Get all the trailer buttons
            var trailerBtns = document.querySelectorAll('.trailer-btn');

            // Get the modal and the close button
            var modal = document.getElementById('trailer-modal');
            var closeBtn = document.querySelector('.close-button');

            // Add event listener to each trailer button
            trailerBtns.forEach(function (btn) {
                btn.addEventListener('click', function () {
                    var trailerLink = this.getAttribute('data-trailer-link');
                    var iframe = modal.querySelector('iframe');
                    iframe.src = trailerLink;
                    modal.style.display = 'block';
                });
            });

            // Add event listener to the close button
            closeBtn.addEventListener('click', function () {
                modal.style.display = 'none';
                var iframe = modal.querySelector('iframe');
                iframe.src = '';
            });

            // Close the modal when clicking outside of it
            window.addEventListener('click', function (event) {
                if (event.target == modal) {
                    modal.style.display = 'none';
                    var iframe = modal.querySelector('iframe');
                    iframe.src = '';
                }
            });
        </script>
        <jsp:include page="ContactUs.jsp" />
    </body>
</html>