<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, cinema.connection.DbConnection, cinema.model.Movie" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Movie Details</title>
        <style>
            body {
                background-color: black;
            }

            h1 {
                color: white;
                text-align: center;
                font-size: 18px;
            }

            h2 {
                color: #ffad33;
                text-align: center;
            }

            h3 {
                color: white;
                text-transform: uppercase;
                font-size: 1.5rem;
            }

            h4 {
                color: green;
            }

            .table-container {
                max-width: 900px;
                margin: 20px auto;
                padding: 20px;
                background-color: #111;
                border-radius: 8px;
            }

            table {
                width: 80%;
                border-collapse: collapse;
                margin: 20px auto;
            }

            th,
            td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }

            th {
                background-color: black;
            }

            input[type="text"],
            input[type="date"],
            select {
                padding: 5px;
                font-size: 14px;
                border-radius: 5px;
                border: 1px solid #555;
                background-color: #222;
                color: #fff;
                width: 90%;
            }

            .table01 {
                width: 100%;
                border-collapse: collapse;
                background-color: black;
            }

            .table01 th {
                vertical-align: top;
                padding: 10px;
                border: none;
            }

            .table01 img {
                width: 100%;
                max-width: 800px;
                height: 350px;
                object-fit: contain;
            }

            .img-cell {
                width: 40%;
            }

            .info-cell {
                width: 60%;
                text-align: left;
                color: #fff;
                font-family: sans-serif;
                font-size: 1.15rem;
            }
            
            .info-cell h2{
                text-align: center;
            }

            .table02 tr th {
                padding: 20px;
                font-family: sans-serif;
            }

            .table02 input[type="date"],
            .table02 select {
                width: 100%;
                padding: 10px;
                font-size: 18px;
                border-radius: 5px;
                border: 1px solid #555;
                background-color: #111;
                color: #fff;
            }

            .container {
                max-width: 1000px;
                margin: 20px auto;
                padding: 20px;
                background-color: #111;
                border-radius: 8px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-bottom: 10px;
                border-bottom: 1px solid #333;
            }

            .header span {
                font-size: 18px;
            }

            .showtime {
                margin-top: 20px;
            }

            .cinema-name {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .details {
                font-size: 16px;
                margin-bottom: 5px;
            }

            .time {
                display: inline-block;
                margin-top: 10px;
                background-color: #000000;
                color: #fff;
                padding: 5px 5px;
                border-radius: 5px;
                font-size: 16px;
            }

            .status {
                margin-top: 10px;
            }

            .status span {
                margin-right: 15px;
                margin-left: 15px;
            }

            .status .available {
                color: #00b300;
            }

            .status .filling {
                color: orange;
            }

            .status .sold {
                color: red;
            }

            .status .lapsed {
                color: gray;
            }

            .distance {
                text-align: right;
                font-size: 14px;
                color: #000000;
            }

            .video-container {
                text-align: center;
            }

            .button-container {
                display: flex;
                justify-content: center;
                gap: 50px;
                margin-bottom: 30px;
            }

            button {
                padding: 10px 30px;
                background-color: #b88b4a;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: large;
            }

            button:hover {
                transform: scale(1.1);
            }

            /* Styles for date input */
            input[type="date"] {
                padding: 10px;
                font-size: 18px;
                border-radius: 5px;
                border: 2px solid #555;
                background-color: #000000;
                color: #fff;
                width: 100%;
                transition: border-color 0.3s;
            }

            input[type="date"]:focus {
                border-color: #000000;
                outline: none;
            }

            input[type="date"]::-webkit-inner-spin-button,
            input[type="date"]::-webkit-outer-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }

            .form-label {
                font-size: 20px;
                color: #ffad33;
                margin-bottom: 10px;
                display: block;
            }

            .show-date-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                margin-top: 20px;
                color: #fff;
            }

            .show-date-block {
                background-color: #000000;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 5px;
                margin: 10px;
                text-align: center;
                width: 100px;
                cursor: pointer;
                color: #fff;
            }

            .show-date-block.selected {
                background-color: #b88b4a;
                color: #fff;
            }

            .hidden-form {
                display: none;
            }

            #hidden-form button {
                display: block;
                margin: 30px auto;
                width: 300px;
                padding: 15px 20px;
                font-size: 20px;
            }
        </style>
    </head>
    <body>
        <%  Movie movie = (Movie) request.getAttribute("movie");
            int movieId = movie.getMovieId();%>
        <div class="video-container">
            <iframe 
                width="1200" 
                height="600" 
                src="<%= movie.getMovieTrailerLink()%>" 
                title="YouTube video player" 
                frameborder="0" 
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                allowfullscreen>
            </iframe>
        </div>
        <div class="container">
            <div class="header">
                <table class="table01">
                    <tr>
                        <th class="img-cell">
                            <img src="<%= movie.getMovieImagePath()%>" alt="<%= movie.getMovieName()%>">
                        </th>
                        <th class="info-cell">
                            <h2>Movie Info</h2>
                            <h3><%= movie.getMovieName()%></h3>
                            <p><%= movie.getMovieContent()%></p>
                            <p>Language: <%= movie.getMovieLanguage()%></p>
                        </th>
                    </tr>
                </table>
            </div>
        </div>
        <h2>Available Show Dates</h2>
        <div class="show-date-container" id="date-container">
            <%

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    conn = DbConnection.getConnection();
                    if (conn == null) {
                        throw new SQLException("Database connection is null.");
                    }
                    String query = "SELECT DISTINCT show_date FROM show_schedule WHERE movie_id = ? ORDER BY show_date";
                    stmt = conn.prepareStatement(query);
                    stmt.setInt(1, movieId);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        LocalDate showDate = rs.getDate("show_date").toLocalDate();
            %>
            <div class="show-date-block" data-date="<%= showDate%>">
                <h1><%= showDate.format(DateTimeFormatter.ofPattern("d-MMM-yyyy"))%></h1>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (stmt != null) try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (conn != null) try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>

        <h2>Available Show Times</h2>
        <div class="show-date-container" id="time-container">
            <%
                try {
                    conn = DbConnection.getConnection();
                    if (conn == null) {
                        throw new SQLException("Database connection is null.");
                    }
                    String query2 = "SELECT DISTINCT show_time FROM show_schedule WHERE movie_id = ?";
                    stmt = conn.prepareStatement(query2);
                    stmt.setInt(1, movieId);
                    rs = stmt.executeQuery();
                    while (rs.next()) {
                        String showTime = rs.getString("show_time");
            %>
            <div class="show-date-block" data-time="<%= showTime%>">
                <h1><%= showTime%></h1>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (stmt != null) try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    if (conn != null) try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>

        <form action="datetimedisplay.jsp" method="post" id="hidden-form">
            <input type="hidden" name="selectedDate" id="selectedDate">
            <input type="hidden" name="selectedTime" id="selectedTime">
            <input type="hidden" name="movieId" value="<%= movieId%>">
            <button type="submit">Book Now</button>
        </form>

        <script>
            let selectedDate = null;
            let selectedTime = null;

            document.querySelectorAll(".show-date-block[data-date]").forEach(block => {
                block.addEventListener("click", function () {
                    document.querySelectorAll(".show-date-block[data-date]").forEach(b => b.classList.remove("selected"));
                    this.classList.add("selected");
                    selectedDate = this.getAttribute("data-date");
                    document.getElementById("selectedDate").value = selectedDate;
                });
            });

            document.querySelectorAll(".show-date-block[data-time]").forEach(block => {
                block.addEventListener("click", function () {
                    document.querySelectorAll(".show-date-block[data-time]").forEach(b => b.classList.remove("selected"));
                    this.classList.add("selected");
                    selectedTime = this.getAttribute("data-time");
                    document.getElementById("selectedTime").value = selectedTime;
                });
            });
        </script>
    </body>
</html>
