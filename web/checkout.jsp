<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="cinema.connection.DbConnection" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Confirmation</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #111;
                color: #fff;
                margin: 0;
                padding: 20px;
                min-height: 100vh;
            }

            .container {
                width: 100%;
                max-width: 800px;
                margin: 20px auto;
                padding: 30px;
                background-color: #222;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
                display: flex;
                flex-direction: column;
            }

            .confirmation-content {
                width: 100%;
                padding: 20px;
                border-radius: 10px;
            }

            .confirmation-content h2 {
                text-align: center;
                font-size: 2rem;
                margin-bottom: 30px;
                color: #f4b400;
                font-weight: bold;
            }

            .details {
                margin-bottom: 20px;
                font-size: 1.1rem;
                line-height: 1.8;
                display: flex;
                justify-content: space-between;
                padding: 10px 20px;
                background-color: #333;
                border-radius: 8px;
                margin: 10px 0;
            }

            .details label {
                font-weight: bold;
                color: #f4b400;
            }

            .details span {
                color: #fff;
                justify-content: space-between;
            }

            .total-cost {
                margin-top: 30px;
                padding: 20px;
                background-color: #333;
                border-radius: 8px;
                font-size: 1.3rem;
            }

            .total-cost label {
                color: #f4b400;
                font-weight: bold;
            }

            .total-cost span {
                float: right;
                color: #fff;
            }

            #confirmBtn {
                display: none;
                background-color: #f4b400;
                color: #000;
                padding: 15px 30px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 1.1rem;
                font-weight: bold;
                width: 100%;
                margin-top: 20px;
                transition: background-color 0.3s ease;
            }

            #confirmBtn:hover {
                background-color: #d49e00;
            }

            #paypal-button-container {
                width: 100%;
                max-width: 700px;
                margin: 20px auto;
                padding: 30px;
                background-color: #222;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                    margin: 10px;
                }
                .details {
                    flex-direction: column;
                    gap: 5px;
                }

                .total-cost span {
                    float: none;
                    display: block;
                    margin-top: 5px;
                }
            }
        </style>

    </head>
    <body>
        <div class="container">
            <div class="confirmation-content">
                <h2>Checkout Confirmation</h2>

                <!-- Booking Details -->
                <div class="details">
                    <label>Movie Name:</label>
                    <span>${movieName}</span>
                </div>
                <div class="details">
                    <label>Show Date:</label>
                    <span>${showDate}</span>
                </div>
                <div class="details">
                    <label>Showtime:</label>
                    <span>${showTime}</span>
                </div>
                <div class="details">
                    <label>Hall:</label>
                    <span>${hallName}</span>
                </div>
                <div class="details">
                    <label>Seats:</label>
                    <span>${seatNumbers}</span>
                </div>
                <div class="details">
                    <label>Cost per Seat:</label>
                    <span>Rs. ${ticketPrice}</span>
                </div>

                <div class="total-cost">
                    <label>Total Seats:</label>
                    <span>${totalSeats}</span><br><br>
                    <label>Total Cost:</label>
                    <span>Rs. ${totalCost}</span>
                </div>

                <!-- Booking Confirmation Form -->
                <form action="UpdateSeats" method="post">
                    <input type="hidden" name="showId" value="${showId != null ? showId : 0}">
                    <input type="hidden" name="email" value="${userEmail}">
                    <input type="hidden" name="movieId" value="${movieId}">
                    <input type="hidden" name="movieName" value="${movieName}">
                    <input type="hidden" name="showDate" value="${showDate}">
                    <input type="hidden" name="showTime" value="${showTime}">
                    <input type="hidden" name="hallName" value="${hallName}">
                    <input type="hidden" name="selectedSeatsId" value="${selectedSeatsId}">
                    <input type="hidden" name="selectedSeats" value="${seatNumbers}">
                    <input type="hidden" name="ticketPrice" value="${ticketPrice}">
                    <input type="hidden" name="totalSeats" value="${totalSeats}">
                    <input type="hidden" name="totalCost" value="${totalCost}">
                    <input type="hidden" name="paymentStatus" value="PENDING"> <!-- Add payment status -->
                    <button type="submit" id="confirmBtn" >Proceed to E-Ticket</button>
                </form>
              <%--Checking whether all the info are passing or not 
            <p>Form Data Debugging:</p>
            <p>Show ID: ${showId}</p>
            <p>Selected Seats: ${selectedSeatsId}</p>
            <p>User Email: ${userEmail}</p>
            <p>${seatNumbers}</p>
            <p>${ticketPrice}</p>
            <p>${totalSeats}</p>--%>

            </div>
            <!-- PayPal Button Container -->
            <div id="paypal-button-container"></div>
            <script src="https://www.paypal.com/sdk/js?client-id=AblFMoCCWcufudjmtsEwycVE5CF41cCexbKOHbD6BREaOFplQhYAdTrd0SJTocJoWSINr58F9d-rvD0X&currency=USD"></script>
            <script>
                // Ensure total cost is converted to a number first
                const totalCost = parseFloat('${totalCost}');
                const convertedAmount = (totalCost / 300).toFixed(2); // Convert LKR to USD

                paypal.Buttons({
                    createOrder: function (data, actions) {
                        console.log('Total Cost (LKR):', '${totalCost}');
                        console.log('Converted Amount (USD):', convertedAmount);

                        // Create the order on PayPal's servers
                        return actions.order.create({
                            purchase_units: [{
                                    amount: {
                                        value: convertedAmount, // Amount in USD
                                        currency_code: 'USD'
                                    }
                                }]
                        });
                    },
                    onApprove: function (data, actions) {
                        // Capture the payment
                        return actions.order.capture().then(function (orderData) {
                            // Display the alert on successful payment
                            console.log('Order Data:', orderData);
                            alert('Payment completed successfully! You can now confirm your booking.');

                            // Make the "Confirm Booking" button visible
                            document.getElementById('confirmBtn').style.display = 'block';

                            // Set the payment status to completed
                            document.querySelector('input[name="paymentStatus"]').value = 'COMPLETED'; // Update payment status
                        });
                    },

                    onError: function (err) {
                        // Handle payment errors
                        console.error('Complete PayPal Error Object:', err);
                        console.error('PayPal Error Name:', err.name);
                        console.error('PayPal Error Message:', err.message);
                        alert('Payment failed: ' + (err.message || 'Unknown error'));
                    }
                }).render('#paypal-button-container');  // Render PayPal buttons in the container

            </script>

        </div>

 <%
            // Handle the POST request
            if (request.getMethod().equalsIgnoreCase("POST")) {
                Connection conn = null;
                PreparedStatement stmt = null;

                try {
                    // Retrieve data from the form
                    int showId = Integer.parseInt(request.getParameter("showId"));
                    String selectedSeats = request.getParameter("${selectedSeatsId}");

                    if (selectedSeats != null && !selectedSeats.isEmpty()) {
                        String[] seatIds = selectedSeats.split(",");
                        boolean allSeatsReserved = true;

                        conn = DbConnection.getConnection();
                        conn.setAutoCommit(false); // Begin transaction

                        for (String seatId : seatIds) {
                            String updateSeatQuery = "UPDATE seats SET is_booked = 1 WHERE seat_id = ? AND show_id = ?";
                            stmt = conn.prepareStatement(updateSeatQuery);
                            stmt.setInt(1, Integer.parseInt(seatId));
                            stmt.setInt(2, showId);

                            int rowsUpdated = stmt.executeUpdate();
                            if (rowsUpdated == 0) {
                                allSeatsReserved = false;
                                break;
                            }
                        }

                        if (allSeatsReserved) {
                            conn.commit(); // Commit transaction if all seats are reserved successfully
                            out.println("<p>Booking confirmed successfully!</p>");
                        } else {
                            conn.rollback(); // Rollback transaction if any seat fails
                            out.println("<p>Failed to reserve all seats. Please try again.</p>");
                        }
                    } else {
                        out.println("<p>No seats selected. Please try again.</p>");
                    }
                } catch (Exception e) {
                    if (conn != null) {
                        conn.rollback(); // Rollback transaction on error
                    }
                    
                } finally {
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                }
            }
        %>
       
    </body>
</html>
