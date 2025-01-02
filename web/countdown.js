/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


// Initial countdown time in seconds (5 minutes = 300 seconds)
let countdownTime = 120;

// Function to format time as MM:SS
function formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
}

// Create the countdown timer display
const countdownDiv = document.createElement('div');
countdownDiv.id = "countdown-timer";
countdownDiv.style.cssText = `
    position: fixed;
    top: 10px;
    left: 20px;
    width: 10%;
    text-align: center;
    font-size: 24px;
    color: #FFD700;
    background-color: rgba(0, 0, 0, 0.8);
    padding: 10px 0;
    z-index: 1000;
`;
document.body.prepend(countdownDiv);

// Initialize the timer display
countdownDiv.innerText = `Time Left: ${formatTime(countdownTime)}`;

// Start the countdown
const timerInterval = setInterval(() => {
    countdownTime--;

    // Update the display
    countdownDiv.innerText = `Time Left: ${formatTime(countdownTime)}`;

    // Alert when 1 minute remains
    if (countdownTime === 60) {
        alert("Only 1 minute remaining to complete your booking!");
    }

    // Handle timer expiry
    if (countdownTime <= 0) {
        clearInterval(timerInterval);
        alert("Time is up! Please restart your booking process.");
        window.location.href = "viewShowDetails.jsp"; // Replace with your desired redirect URL
    }
}, 1000);

