<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Report</title>
        <link rel="stylesheet" href="feedback.css">
        <style>

            /* General Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body Styling */
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh; /* Full height of viewport */
                font-family: Arial, sans-serif;
                background-color: #1a1a1a;
                color: #333;
                overflow-x: hidden;
            }

            /* Main Container Styling */
            .container {
                flex: 1; /* Makes the container grow to fill available space above footer */
                display: flex;
                gap: 1rem; /* Space between navigation and content */
                margin: 10px;
            }

            .left {
                flex-basis: 20%; /* Takes 20% of the width */
                padding: 1rem;
            }

            .right {
                flex-basis: 80%; /* Takes 80% of the width */
                padding: 30px;
                background-color: #333333;
                color: white;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.7);
                text-align: center;
            }

            header {
                margin-bottom: 40px;
            }

            header h1 {
                font-size: 30px;
                letter-spacing: 2px;
                font-weight: bold;
            }
            .charts {
                margin-top: 20px;
            }
            .chart-container h2{
                position: absolute;
                margin-top:20px;
                margin-left:30px;
                color:#0056b3;
            }

            .monthly-revenue{
                position: absolute;
                margin-top:20px;
                margin-left:80%;
                font-size: 27px;
                color:red;
            }

            .chart-container {
                background-color: white;
                width: 100%;
                height: 78%;
                margin-top: 0px;
                box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                position: relative;
            }

            .chart-container canvas {
                position:absolute;
                margin-top:50px;
                width: 80%;
                height: 100%;
            }

            .chart-wrapper {
                padding: 20px;
                margin-top: 60px;
                height: 400px;
                width: 100%;
                position: relative;
            }

        </style>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
        <div class="container">
            <div class="left">
                <jsp:include page="NavBar.jsp" />
            </div>
            <div class="right">
                <header><h1>Report Overview</h1></header>
                <div class="chart-container">
                    <h2>Revenue</h2>
                    <<div class="monthly-revenue">LKR 150,000</div> 
                    <div class="chart-wrapper">
                        <canvas id="monthlyRevenueChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const ctx = document.getElementById('monthlyRevenueChart').getContext('2d');

                // Sample data - replace with your actual data
                const data = {
                    labels: ['January', 'February', 'March', 'April', 'May', 'June'],
                    datasets: [{
                            label: 'Monthly Revenue',
                            data: [65000, 59000, 80000, 81000, 56000, 150000],
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 2,
                            tension: 0.4
                        }]
                };

                const config = {
                    type: 'line',
                    data: data,
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function (value) {
                                        return 'LKR ' + value.toLocaleString();
                                    }
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            title: {
                                display: false
                            }
                        }
                    }
                };

                new Chart(ctx, config);
            });
        </script>
    </body>
</html>

