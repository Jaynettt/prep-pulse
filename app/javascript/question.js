document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector(".question-form"); // Adjust this selector if necessary
  form.addEventListener("ajax:success", (event) => {
    const detail = event.detail[0]; // The response from the server
    const nextQuestionPath = detail.next_question_path; // Expecting the path in the response
    if (nextQuestionPath) {
      window.location.href = nextQuestionPath; // Redirect to the next question
    } else {
      // Handle completion message if there are no more questions
      document.querySelector(".vwew").innerHTML = "<p>Congratulations! You have answered all questions from this category.</p>";
    }
  });
  form.addEventListener("ajax:error", (event) => {
    const errorMessage = event.detail[0].error; // Assuming your controller responds with error details
    alert("Error submitting answer: " + errorMessage);
  });
});
