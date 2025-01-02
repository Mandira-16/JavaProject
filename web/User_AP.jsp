<%@page import="java.util.List"%>
<%@page import="cinema.connection.DbConnection"%>
<%@page import="cinema.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Panel - User Management</title>
        <link href="https://fonts.googleapis.com/css2?family=Sharp+Sans:wght@400;500&display=swap" rel="stylesheet">
        <style>
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
            /* Main content area */
            .main-content {
                margin-left: 260px;
                width: 100%;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                min-height: 100vh;
                overflow-y: auto;
            }

            header {
                background-color: #333;
                color: #fff;
                padding: 10px 0;
                text-align: center;
                position: relative;
            }
            /* Search Bar Styles */
            .search-bar {
                margin: 20px 0;
                display: inline; /* Allows elements to be side by side */
                width: 100%;           /* Adjust width as needed */
                margin-left: 150px;  /* Add some space between elements */
                vertical-align: middle; /* Vertically align the elements */
                margin-top: 20px;
            }
            .h1{
                margin-top: 30px;
            }

            .search-bar input {
                width: 60%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                margin-top: 20px;
            }

            /* Table Styles */
            .user-table {
                width: 100%;
                border-collapse: collapse;
                margin: 50px 0;
            }

            .user-table th, .user-table td {
                padding: 12px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            .user-table th {
                background-color: #333;
                color: white;
            }

            .user-table td button {
                padding: 8px 16px;
                border: none;
                color: white;
                cursor: pointer;
                font-size: 14px;
            }

            .delete-btn {
                background-color: #ff4c4c;
            }

            .block-btn {
                background-color: #ffcc00;
            }
            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                width: 40%;
                text-align: center;
            }

            .modal-content button {
                padding: 10px 20px;
                margin-top: 20px;
                background-color: #ff4c4c;
                color: white;
                border: none;
                cursor: pointer;
                font-size: 16px;
            }

            .modal-content button:hover {
                background-color: #e63946;
            }
            .Loadbtn button{
                padding: 12px 20px;
                border: none;
                border-radius: 5px;
                background-color: #007bff;
                color: white;
                cursor: pointer;
                font-size: 16px;
            }
            .Loadbtn {
                display: inline-block;
                vertical-align: middle;
                margin-top: 20px;
            }
            .Loadbtnt button:hover{
                background-color: #a1793b;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar Navigation -->
        <div class="container">
            <div class="left">
                <jsp:include page="NavBar.jsp" />
            </div>

            <div class="right">

                <header>
                    <h1>User Management</h1>
                </header>

                <!-- Search Bar -->
                <div class="search-bar">
                    <input type="text" id="searchInput" placeholder="Search by name">
                </div>
                <div class="Loadbtn">
                    <form action="user-list" method="get"> <%-- Or post if needed --%>
                        <button type="submit">Load Users</button>
                    </form>
                </div>
                <!-- User Table -->
                <table class="user-table" id="userTable">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <!-- Sample data -->
                    <tbody>
                        <%
                            List<User> userList = (List<User>) request.getAttribute("userList");
                            if (userList != null) {
                                for (User user : userList) {
                        %>
                        <tr>
                            <td><%= user.getId()%></td>
                            <td><%= user.getFirstName() + " " + user.getLastName()%></td>
                            <td><%= user.getEmail()%></td>
                            <td><%= user.getPhone()%></td>
                            <td>
                                <button class="block-btn">Block</button>
                                <button class="delete-btn">Delete</button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="5">No users found.</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>

