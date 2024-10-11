import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["form", "start", "slidingDiv"];

  connect() {
    // Set the total time for the quiz (in seconds)
    const totalTime = 2 * 60; // This should likely be 15 * 60 for 15 minutes
    const start = Date.now()
    this.startTarget.value = start
    let timeLeft = totalTime;
    console.log(timeLeft);

    const timerDisplay = this.element.querySelector(".time-display"); // Select the time display span

    // Update the timer display every second
    this.timer = setInterval(() => { // Use an arrow function here
      if (timeLeft <= 0) {
        clearInterval(this.timer);
        // alert("Time's up! Submitting your answer.");
        this.formTarget.submit(); // Call the method correctly

      } else {
        const minutes = Math.floor((timeLeft % 3600) / 60);
        const seconds = timeLeft % 60;

        // Update the timer display with mm:ss format

        timerDisplay.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;

        // Decrease the time left by one second
        timeLeft--;
      }
    }, 1000);
  }

  submit(event) {
    event.preventDefault();
    this.slidingDivTarget.classList.add('slide-out');

    setTimeout(() => {
      this.formTarget.submit();
    }, 500); // Adjust timing to match the CSS animation
  }


}
