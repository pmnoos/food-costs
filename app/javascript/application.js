// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Rails from "@rails/ujs"
Rails.start()

// Enhanced alert functionality
document.addEventListener('turbo:load', function() {
  // Initialize Bootstrap alerts
  const alerts = document.querySelectorAll('.alert');
  
  alerts.forEach(alert => {
    // Auto-dismiss alerts after 5 seconds
    setTimeout(() => {
      if (alert && alert.classList.contains('show')) {
        // Use Bootstrap's alert dismiss method
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }
    }, 5000);

    // Enhanced close button functionality
    const closeButton = alert.querySelector('.btn-close');
    if (closeButton) {
      closeButton.addEventListener('click', function(e) {
        e.preventDefault();
        e.stopPropagation();
        
        // Add slide-up animation
        alert.style.animation = 'slideUp 0.3s ease-out';
        
        setTimeout(() => {
          // Use Bootstrap's alert dismiss method
          const bsAlert = new bootstrap.Alert(alert);
          bsAlert.close();
        }, 300);
      });
    }
  });

  // Account dropdown enhancements
  const accountDropdown = document.querySelector('#navbarDropdown');
  const dropdownMenu = document.querySelector('.dropdown-menu');
  
  if (accountDropdown && dropdownMenu) {
    // Add smooth show/hide animations
    accountDropdown.addEventListener('show.bs.dropdown', function() {
      dropdownMenu.style.opacity = '0';
      dropdownMenu.style.transform = 'translateY(-10px)';
      
      setTimeout(() => {
        dropdownMenu.style.transition = 'all 0.3s ease';
        dropdownMenu.style.opacity = '1';
        dropdownMenu.style.transform = 'translateY(0)';
      }, 10);
    });
    
    accountDropdown.addEventListener('hide.bs.dropdown', function() {
      dropdownMenu.style.transition = 'all 0.2s ease';
      dropdownMenu.style.opacity = '0';
      dropdownMenu.style.transform = 'translateY(-10px)';
    });
    
    // Add hover effects to dropdown items
    const dropdownItems = dropdownMenu.querySelectorAll('.dropdown-item');
    dropdownItems.forEach(item => {
      item.addEventListener('mouseenter', function() {
        this.style.transform = 'translateX(5px)';
      });
      
      item.addEventListener('mouseleave', function() {
        this.style.transform = 'translateX(0)';
      });
    });
    
    // Special logout button enhancement
    const logoutButton = dropdownMenu.querySelector('button[type="submit"]');
    if (logoutButton) {
      logoutButton.addEventListener('click', function(e) {
        // Add a small delay to show the click effect
        this.style.transform = 'scale(0.95)';
        setTimeout(() => {
          this.style.transform = 'scale(1)';
        }, 150);
      });
    }
  }
  
  // Add ripple effect to buttons
  const buttons = document.querySelectorAll('.btn, .dropdown-item');
  buttons.forEach(button => {
    button.addEventListener('click', function(e) {
      const ripple = document.createElement('span');
      const rect = this.getBoundingClientRect();
      const size = Math.max(rect.width, rect.height);
      const x = e.clientX - rect.left - size / 2;
      const y = e.clientY - rect.top - size / 2;
      
      ripple.style.width = ripple.style.height = size + 'px';
      ripple.style.left = x + 'px';
      ripple.style.top = y + 'px';
      ripple.classList.add('ripple');
      
      this.appendChild(ripple);
      
      setTimeout(() => {
        ripple.remove();
      }, 600);
    });
  });
});
