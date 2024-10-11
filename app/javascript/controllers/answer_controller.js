import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="answer"
export default class extends Controller {
  static targets = ["slidingDiv"];

  slideDown(event) {
    event.preventDefault();

    // Add the slide-out class to trigger the animation
    this.slidingDivTarget.classList.add('slide-out');

    // Navigate to the link after the animation completes
    const url = event.currentTarget.href; // Get the link's URL

    setTimeout(() => {
      window.location.href = url; // Redirect to the URL
    }, 500); // The timeout matches the CSS animation duration
  }

  slideUp(event) {
    event.preventDefault();

    // Add the slide-out class to trigger the animation
    this.slidingDivTarget.classList.add('slide-up');

    // Navigate to the link after the animation completes
    const url = event.currentTarget.href; // Get the link's URL

    setTimeout(() => {
      window.location.href = url; // Redirect to the URL
    }, 500); // The timeout matches the CSS animation duration
  }
}
