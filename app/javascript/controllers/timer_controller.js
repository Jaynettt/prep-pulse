import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["form"];

  connect() {
    // Set the total time for the quiz (in seconds)
    const totalTime = 2 * 60; // This should likely be 15 * 60 for 15 minutes
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

  submitForm() {
    fetch(this.formTarget.action, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content // Include CSRF token
      },
      body: new FormData(this.formTarget)
    })
      .then(response => {
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        return response.json();
      })
      .then((data) => {
        this.element.outerHTML = data.form
        // Handle successful submission, e.g., redirect or update UI
      })
      .catch(error => {
        console.error("There was a problem with the fetch operation:", error);
      });
  }
}
