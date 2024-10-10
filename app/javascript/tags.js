document.addEventListener("DOMContentLoaded", () => {
  const tags = document.querySelectorAll('.tag');
  const categoryIdsField = document.getElementById('category_ids');

  tags.forEach(tag => {
    tag.addEventListener('click', () => {
      // Toggle selected class
      tag.classList.toggle('selected');

      // Update the hidden field with selected category IDs
      const selectedIds = Array.from(tags)
        .filter(tag => tag.classList.contains('selected'))
        .map(tag => tag.getAttribute('data-category-id'));

      categoryIdsField.value = selectedIds.join(',');
    });
  });
});
