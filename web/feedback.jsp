<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Form</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #121212;
                color: #fff;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                flex-direction: column;
                min-height: 100vh;
                transition: background-color 0.3s;
            }

            .container {
                width: 100%;
                max-width: 800px;
                margin-top: 30px;
            }

            .feedback-form {
                background: #1c1c1c;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.8);
                margin-bottom: 30px;
            }

            .form-group {
                margin-bottom: 25px;
                position: relative;
            }

            .form-group label {
                color: #bbb;
                font-weight: bold;
                display: block;
                margin-bottom: 15px;
            }

            .radio-group {
                display: flex;
                justify-content: space-between;
                gap: 10px;
            }

            .radio-option {
                flex: 1;
                text-align: center;
            }

            .radio-option input[type="radio"] {
                display: none;
            }

            .radio-option label {
                display: block;
                padding: 10px;
                background: #2c2c2c;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s;
                margin: 0;
                color: #fff;
            }

            .radio-option input[type="radio"]:checked + label {
                background: #ffad33;
                color: #fff;
            }

            .form-group button {
                background: #ffad33;
                color: #fff;
                padding: 12px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                width: 100%;
                font-size: 18px;
                transition: background 0.3s;
            }

            .form-group button:hover {
                background: #e6992e;
            }

            .loading {
                display: none;
                text-align: center;
                font-size: 18px;
                color: #fff;
                padding: 20px;
            }

            .form-control:focus {
                background: #2c2c2c;
                color: #fff;
                box-shadow: 0 0 0 0.2rem rgba(255, 173, 51, 0.25);
                border: none;
            }

            .form-control::placeholder {
                color: #666;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="feedback-form">
                <h2 class="form-title text-center">Feedback Form</h2>
                <form id="feedbackForm" action="FeedbackServlet" method="POST">
                    <!-- Movie Questions -->
                    <div class="form-group">
                        <label>Name:</label>
                        <input type="text" class="form-control" id="name" name="name" required style="background: #2c2c2c; border: none; color: #fff; padding: 10px; border-radius: 5px;">
                    </div>

                    <div class="form-group">
                        <label>Phone Number:</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required style="background: #2c2c2c; border: none; color: #fff; padding: 10px; border-radius: 5px;">
                    </div>

                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" class="form-control" id="email" name="email" required style="background: #2c2c2c; border: none; color: #fff; padding: 10px; border-radius: 5px;">
                    </div>

                    <div class="form-group">
                        <label>1. Rate the Movie:</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="movie-dissatisfied" name="movieRating" value="dissatisfied">
                                <label for="movie-dissatisfied">Dissatisfied</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="movie-neutral" name="movieRating" value="neutral">
                                <label for="movie-neutral">Neutral</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="movie-satisfied" name="movieRating" value="satisfied">
                                <label for="movie-satisfied">Satisfied</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>2. Rate the Storyline:</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="storyline-dissatisfied" name="storylineRating" value="dissatisfied">
                                <label for="storyline-dissatisfied">Dissatisfied</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="storyline-neutral" name="storylineRating" value="neutral">
                                <label for="storyline-neutral">Neutral</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="storyline-satisfied" name="storylineRating" value="satisfied">
                                <label for="storyline-satisfied">Satisfied</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>3. Rate the Cinematography:</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="cinematography-dissatisfied" name="cinematographyRating" value="dissatisfied">
                                <label for="cinematography-dissatisfied">Dissatisfied</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="cinematography-neutral" name="cinematographyRating" value="neutral">
                                <label for="cinematography-neutral">Neutral</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="cinematography-satisfied" name="cinematographyRating" value="satisfied">
                                <label for="cinematography-satisfied">Satisfied</label>
                            </div>
                        </div>
                    </div>

                    <!-- Hall Questions -->
                    <div class="form-group">
                        <label>4. Rate the Hall Cleanliness:</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="cleanliness-dissatisfied" name="cleanliness" value="dissatisfied">
                                <label for="cleanliness-dissatisfied">Dissatisfied</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="cleanliness-neutral" name="cleanliness" value="neutral">
                                <label for="cleanliness-neutral">Neutral</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="cleanliness-satisfied" name="cleanliness" value="satisfied">
                                <label for="cleanliness-satisfied">Satisfied</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>5. Rate the Seating Comfort:</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="comfort-dissatisfied" name="comfort" value="dissatisfied">
                                <label for="comfort-dissatisfied">Dissatisfied</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="comfort-neutral" name="comfort" value="neutral">
                                <label for="comfort-neutral">Neutral</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="comfort-satisfied" name="comfort" value="satisfied">
                                <label for="comfort-satisfied">Satisfied</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>6. Rate the Sound Quality:</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="sound-dissatisfied" name="soundQuality" value="dissatisfied">
                                <label for="sound-dissatisfied">Dissatisfied</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="sound-neutral" name="soundQuality" value="neutral">
                                <label for="sound-neutral">Neutral</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="sound-satisfied" name="soundQuality" value="satisfied">
                                <label for="sound-satisfied">Satisfied</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label>7. Any other feedback:</label>
                        <textarea class="form-control" id="otherfeedback" name="otherfeedback" rows="4" 
                                  style="background: #2c2c2c; border: none; color: #fff; padding: 10px; border-radius: 5px;" 
                                  placeholder="Write any additional comments or suggestions here..."></textarea>
                    </div>


                    <!-- Submit Button -->
                    <div class="form-group">
                        <button type="submit" id="submitBtn">Submit Feedback</button>

                    </div>
                </form>
            </div>
        </div>

        <script>
            // Handle form submission
            document.getElementById('feedbackForm').addEventListener('submit', function (event) {
            document.getElementById('loading').style.display = 'block';
                    document.getElementById('submitBtn').disabled = true;
        </script>
    </body>
</html>