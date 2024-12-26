// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {
  // Select all the buttons with the class 'copy-button'
  const copyButtons = document.querySelectorAll('.copy-button');
  console.log(copyButtons.length)
  copyButtons.forEach(button => {
    button.addEventListener('click', async () => {
      const targetId = button.getAttribute('data-target'); // Get the target from data-target attribute
      const textToCopy = document.querySelector(targetId); // Find the corresponding input element

      if (textToCopy) {
        try {
          // Copy the value from the corresponding input
          await navigator.clipboard.writeText(textToCopy.value);
          alert('Text copied to clipboard!');
        } catch (err) {
          alert('Failed to copy text.');
        }
      }
    });
  });
});

