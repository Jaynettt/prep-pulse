document.addEventListener("DOMContentLoaded", () => {
  const tags = document.querySelectorAll('.tag');
  const categoriesContainer = document.getElementById('categories-container');

  tags.forEach(tag => {
    tag.addEventListener('click', () => {
      // Toggle selected class
      tag.classList.toggle('selected');

      // Remove existing hidden inputs for category_ids[]
      document.querySelectorAll('input[name="pulse[category_ids][]"]').forEach(input => input.remove());

      // Create hidden inputs for selected categories
      const selectedTags = Array.from(tags)
        .filter(tag => tag.classList.contains('selected'));

      selectedTags.forEach(tag => {
        const hiddenField = document.createElement('input');
        hiddenField.type = 'hidden';
        hiddenField.name = 'pulse[category_ids][]';  // Ensure Rails treats this as an array
        hiddenField.value = tag.getAttribute('data-category-id');
        categoriesContainer.appendChild(hiddenField);
      });

      // Ensure an empty array is submitted if no categories are selected
      if (selectedTags.length === 0) {
        const hiddenField = document.createElement('input');
        hiddenField.type = 'hidden';
        hiddenField.name = 'pulse[category_ids][]';  // This ensures an empty array is sent
        hiddenField.value = '';  // Empty string as a placeholder for no selection
        categoriesContainer.appendChild(hiddenField);
      }
    });
  });
});
