<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notification Page</title>
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
            }
            .container {
                display: flex;
                gap: 1rem;

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


            header {
                text-align: center;
                margin-bottom: 40px;
            }

            header h1 {
                color: white;
                font-size: 40px;
                letter-spacing: 2px;
            }

            /* Search Bar */
            .search-bar {
                margin-bottom: 20px;
                display: flex;
                justify-content: center;
            }

            .search-bar input {
                width: 50%;
                padding: 10px;
                font-size: 16px;
                border-radius: 5px;
                border: 1px solid #888;
                background-color: #333;
                color: white;
            }

            /* Notification System Section */
            .notification-system {
                display: flex;
                justify-content: space-between;
                gap: 30px;
                margin-bottom: 30px;
            }

            /* Notification Box */
            .notification-box {
                flex: 1;
                background-color: #444444;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.6);
            }

            .notification-box h3 {
                color: white;
                font-size: 22px;
                margin-bottom: 20px;
            }

            .notifications {
                max-height: 400px;
                overflow-y: auto;
                margin-bottom: 20px;
            }

            .notification-item {
                background-color: #555555;
                padding: 15px;
                margin-bottom: 10px;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .notification-item:hover {
                background-color: #666666;
            }

            .notification-item span {
                font-size: 16px;
                color: white;  /* Ensure notification text is white */
            }

            .notification-item .message {
                color: white;  /* White for the message text */
                font-weight: bold;
            }

            /* Send Message Form */
            .send-message-form {
                flex: 1;
                background-color: #444444;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.6);
            }

            .send-message-form h3 {
                color: white;  /* White color for the heading */
                font-size: 22px;
                margin-bottom: 20px;
            }

            .send-message-form label {
                color: white;  /* Ensure labels are white */
                font-size: 16px;
                display: block;
                margin-bottom: 8px;
            }

            .send-message-form textarea {
                width: 100%;
                height: 150px;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #888;
                color: white;  /* Ensure text in textarea is white */
                background-color: #333333;
                font-size: 14px;
                margin-bottom: 20px;
                resize: none;
            }

            /* Gold button styling */
            .send-message-form button {
                background-color: #b88b4a;  /* Gold background for the button */
                color: white;  /* White text */
                border: none;
                padding: 12px 20px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .send-message-form button:hover {
                transform:scale(1.1);
            }

            /* Footer */
            footer {
                text-align: center;
                margin-top: 40px;
                color: white;  /* Make footer text white */
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="left">
                <jsp:include page="NavBar.jsp" />
            </div>

            <div class="right">
                <div >
                    <header>
                        <h1>Notification System</h1>
                    </header>

                    <!-- Search Bar -->
                    <div class="search-bar">
                        <input type="text" id="search-input" placeholder="Search notifications..." onkeyup="searchNotifications()">
                    </div>

                    <!-- Notification System Section -->
                    <div class="notification-system">
                        <!-- Notifications Box -->
                        <div class="notification-box">
                            <h3>Recent Notifications</h3>
                            <div class="notifications" id="notifications">
                                <!-- Notification Items will be dynamically inserted here -->
                            </div>
                        </div>

                        <!-- Send Message Form -->
                        <div class="send-message-form">
                            <h3>Send a Notification</h3>
                            <form id="message-form" onsubmit="sendMessage(event)">
                                <label for="notification-message">Enter your notification message:</label>
                                <textarea id="notification-message" name="message" required placeholder="Type your message..."></textarea>
                                <button type="submit">Send Notification</button>
                            </form>
                        </div>
                    </div>
                </div>
                <script>
                    // Array to store notifications
                    let notifications = [];

                    // Function to render notifications in the UI
                    function renderNotifications(filteredNotifications = notifications) {
                        const notificationsContainer = document.getElementById('notifications');
                        notificationsContainer.innerHTML = '';

                        // Loop through notifications and create elements
                        filteredNotifications.forEach((notification, index) => {
                            const notificationItem = document.createElement('div');
                            notificationItem.classList.add('notification-item');

                            // Displaying the message
                            const message = document.createElement('span');
                            message.classList.add('message');
                            message.textContent = notification.message;

                            // Displaying the time of the notification
                            const time = document.createElement('span');
                            time.textContent = ` - Sent at: ${notification.time}`;

                            notificationItem.appendChild(message);
                            notificationItem.appendChild(time);

                            notificationsContainer.appendChild(notificationItem);
                        });
                    }

                    // Function to handle sending a message
                    function sendMessage(event) {
                        event.preventDefault();  // Prevent form submission

                        const messageInput = document.getElementById('notification-message');
                        const messageText = messageInput.value.trim();

                        if (messageText === '') {
                            alert('Please type a message before sending.');
                            return;
                        }

                        // Create a new notification object with current date and time
                        const notification = {
                            message: messageText,
                            time: new Date().toLocaleString(),
                        };

                        // Add the new notification to the array
                        notifications.push(notification);

                        // Clear the input field
                        messageInput.value = '';

                        // Render the updated notifications
                        renderNotifications();
                    }

                    // Function to search notifications by message content
                    function searchNotifications() {
                        const searchInput = document.getElementById('search-input').value.toLowerCase();
                        const filteredNotifications = notifications.filter(notification =>
                            notification.message.toLowerCase().includes(searchInput)
                        );
                        renderNotifications(filteredNotifications);
                    }

                    // Initially render any existing notifications (if any)
                    renderNotifications();
                </script>

            </div>
        </div>
        <footer>
            <p>&copy; 2024 Filmor. All rights reserved &REG;</p>
        </footer>
    </body>
</html>
