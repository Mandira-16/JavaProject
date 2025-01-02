<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <script>
            function checkAdminCookie() {
                const cookies = document.cookie.split(';');
                let hasAdminCookie = false;

                for (let cookie of cookies) {
                    const [name, value] = cookie.trim().split('=');
                    if (name === 'admin_session') {
                        hasAdminCookie = true;
                        break;
                    }
                }

                if (!hasAdminCookie) {
                    window.location.href = 'Login.jsp';
                }
            }

// Check cookies every 5 seconds
            setInterval(checkAdminCookie, 100);
        </script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Panel - Sidebar</title>
        <link href="https://fonts.googleapis.com/css2?family=Sharp+Sans:wght@300;400;600&display=swap" rel="stylesheet">
        <style>
            .sidebar {
                background-color: #333;
                width: 250px;
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                padding: 20px 20px;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }
            .sidebar-nav {
                flex-grow: 1;
            }
            .sidebar-header {
                text-align: center;
                margin-bottom: 20px;
            }
            .sidebar-logo {
                width: 150px;
            }

            .sidebar-nav ul {
                list-style: none;
                padding: 0 15px;
                margin: 0;
            }

            .sidebar-nav li {
                margin: 25px 0;
            }
            .sidebar-nav a {
                color: #fff;
                text-decoration: none;
                font-size: 22px;
                padding: 12px 10px;
                display: block;
                transition: background-color 0.3s, transform 0.2s, box-shadow 0.2s;
                border-radius: 5px;
                font-weight: bold;
                text-align: center;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .sidebar-nav h2{
                color: #fff;
                margin-left:37px;
                font-size: 19px;
            }

            .sidebar-nav a:hover {
                background-color: #444;
                transform: translateY(-4px);
                box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2);
            }

            .logout-btn {
                background-color: #d9534f;
                color: #fff;
                border: none;
                padding: 12px 20px;
                width: 100%;
                font-size: 18px;
                cursor: pointer;
                border-radius: 5px;
                font-weight: bold;
                text-align: center;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                transition: transform 0.2s, box-shadow 0.2s;
                margin-bottom: 20px;
            }

            .logout-btn:hover {
                background-color: #c9302c;
                transform: translateY(-4px);
                box-shadow: 0 6px 8px rgba(0, 0, 0, 0.2);
            }

        </style>
    </head>
    <body>

        <div class="sidebar">
            <!-- Sidebar Header -->
            <div class="sidebar-header">
                <img src="images\Filmor Logo.jpg" alt="Filmor Cinema Logo" class="sidebar-logo">
            </div>
            <h2><font color="white" align="center">Admin Dashboard</font></h2>
            <!-- Sidebar Navigation -->
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="addMovie.jsp">Movie</a></li>
                    <li><a href="Ticket_AP.jsp">Theater</a></li>
                    <li><a href="User_AP.jsp">User</a></li>
                    <li><a href="Feedback_AP.jsp">Feedback</a></li>
                    <li><a href="Report_AP.jsp">Report</a></li>
                    <li><a href="Notify_AP.jsp">Notification</a></li>
                </ul>
                <!-- Logout Button -->
                <button class="logout-btn" onclick="window.location.href = 'LogoutServlet'">Log Out</button>
            </nav>
        </div>
        <!-- Add this script section just before closing </body> tag in NavBar.jsp -->

    </body>
</html>
