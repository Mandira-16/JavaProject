<%@ page import="cinema.dao.FeedbackDAO" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Feedback Overview</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body and Background */
            body {
                font-family: Arial, sans-serif;
                background-color: #1a1a1a;
                color: white;
                padding: 40px;
                overflow-x: hidden;
                transition: all 0.3s ease;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* Container Layout */
            .container {
                display: flex;
                gap: 1rem;
                margin: 10px;
                justify-content: center;
                border-radius: 8px;
                overflow: hidden;
            }

            .left {
                flex-basis: 20%;
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

            /* Header Styles */
            h1 {
                text-align: center;
                font-size: 2.5em;
                margin-bottom: 40px;
                color: white;
                margin-top: 30px;
            }

            /* Table Styles */
            .feedback-table {
                width: 100%;
                margin: 0px 0;
                overflow-x: auto;
                padding-bottom: 10px
            }

            .feedback-table::-webkit-scrollbar {
                width: 10px;
                height: 10px;
            }

            .feedback-table::-webkit-scrollbar-thumb {
                background: #ffad33; /* Scrollbar color */
                border-radius: 5px; /* Rounded corners */
            }

            .feedback-table::-webkit-scrollbar-thumb:hover {
                background: #e6992e; /* Hover effect color */
            }

            .feedback-table::-webkit-scrollbar-track {
                background: #1c1c1c; /* Track color */
                border-radius: 5px; /* Rounded corners */
            }

            .data-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 10px;
            }

            .data-table th,
            .data-table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #444;
            }

            .data-table th {
                background-color: #333;
                color: white;
                font-weight: 500;
                text-transform: uppercase;
            }

            .data-table tr:hover {
                background-color: #2c2c2c;
            }

            .data-table tr:last-child td {
                border-bottom: none;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <div class="left">
                <jsp:include page="NavBar.jsp" />
            </div>
            <div class="right">
                <h1>Feedback Overview</h1>
                <div class="feedback-table">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Name</th>
                                <th>Phone Number</th>
                                <th>Email</th>
                                <th>Movie Rating</th>
                                <th>Story -line</th>
                                <th>Visuals</th>
                                <th>Cleanliness</th>
                                <th>Comfort</th>
                                <th>Sound</th>
                                <th>Other</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                FeedbackDAO dao = new FeedbackDAO();
                                List<Map<String, String>> feedbackList = dao.getAllFeedback();
                                for (Map<String, String> feedback : feedbackList) {
                            %>
                            <tr>
                                <td><%= feedback.get("submissionDate")%></td>
                                <td><%= feedback.get("name")%></td>
                                <td><%= feedback.get("phone")%></td>
                                <td><%= feedback.get("email")%></td>
                                <td><%= feedback.get("movieRating")%></td>
                                <td><%= feedback.get("storylineRating")%></td>
                                <td><%= feedback.get("cinematographyRating")%></td>
                                <td><%= feedback.get("cleanliness")%></td>
                                <td><%= feedback.get("comfort")%></td>
                                <td><%= feedback.get("soundQuality")%></td>
                                <td><%= feedback.get("otherfeedback")%></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>