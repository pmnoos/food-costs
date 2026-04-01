import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

function flagBrokenImages() {
  const clearBroken = (img) => {
    if (!img) return;

    img.classList.remove('is-broken-image');
    img.removeAttribute('title');
    delete img.dataset.brokenImageHandled;

    const container = img.closest('.broken-image-flag') || img.parentElement;
    if (!container) return;

    const badge = container.querySelector('.broken-image-badge');
    if (badge) badge.remove();

    if (!container.querySelector('.broken-image-badge')) {
      container.classList.remove('broken-image-flag');
    }
  };

  const markBroken = (img) => {
    if (!img || img.dataset.brokenImageHandled === 'true') return;

    img.dataset.brokenImageHandled = 'true';
    img.classList.add('is-broken-image');

    if (!img.alt || img.alt.trim() === '') {
      img.alt = 'Image unavailable';
    }

    img.title = 'Image failed to load';

    const container = img.closest('.broken-image-flag') || img.parentElement;
    if (!container || container.querySelector('.broken-image-badge')) return;

    container.classList.add('broken-image-flag');

    const badge = document.createElement('span');
    badge.className = 'broken-image-badge';
    badge.textContent = 'Image unavailable';
    container.appendChild(badge);
  };

  document.querySelectorAll('img').forEach((img) => {
    img.addEventListener('error', () => markBroken(img), { once: true });
    img.addEventListener('load', () => clearBroken(img));
  });
}

function initProductAutocomplete() {
  const nameInput = document.getElementById('product_name');
  if (!nameInput) return;

  // Remove any existing suggestion box
  let oldBox = document.getElementById('autocomplete-suggestions-box');
  if (oldBox) oldBox.remove();

  // Create suggestion box
  const suggestionBox = document.createElement('div');
  suggestionBox.id = 'autocomplete-suggestions-box';
  suggestionBox.className = 'autocomplete-suggestions card shadow position-absolute';
  suggestionBox.style.zIndex = 1000;
  suggestionBox.style.display = 'none';
  nameInput.parentNode.appendChild(suggestionBox);
  nameInput.setAttribute('autocomplete', 'off');

  nameInput.addEventListener('input', function() {
    const term = nameInput.value.trim();
    console.log('Input event fired, term:', term);
    if (term.length < 2) {
      suggestionBox.style.display = 'none';
      return;
    }
    fetch('/products/autocomplete.json?term=' + encodeURIComponent(term))
      .then(r => {
        console.log('Fetch to /products/autocomplete.json returned status:', r.status);
        return r.json();
      })
      .then(data => {
        console.log('Autocomplete data:', data);
        suggestionBox.innerHTML = '';
        if (data.length === 0) {
          suggestionBox.style.display = 'none';
          return;
        }
        data.forEach(function(item) {
          const div = document.createElement('div');
          div.className = 'autocomplete-suggestion list-group-item list-group-item-action';
          div.textContent = item.name;
          div.style.cursor = 'pointer';
          div.addEventListener('mousedown', function(e) {
            e.preventDefault();
            nameInput.value = item.name;
            suggestionBox.style.display = 'none';
            // Fill other fields robustly
            const storeSelect = document.getElementById('product_store_id');
            if (storeSelect && item.store_id) storeSelect.value = item.store_id;
            const unitSelect = document.getElementById('product_unit');
            if (unitSelect && item.unit) unitSelect.value = item.unit;
            const quantityInput = document.getElementById('product_quantity');
            if (quantityInput && item.quantity) {
              quantityInput.value = item.quantity;
              quantityInput.dispatchEvent(new Event('input', { bubbles: true }));
            }
            const unitPriceInput = document.getElementById('product_unit_price');
            if (unitPriceInput && item.unit_price) {
              unitPriceInput.value = item.unit_price;
              unitPriceInput.dispatchEvent(new Event('input', { bubbles: true }));
            }
            const totalCostInput = document.getElementById('product_total_cost');
            if (totalCostInput && item.total_cost) totalCostInput.value = item.total_cost;
            const purchaseDateInput = document.getElementById('product_purchase_date');
            if (purchaseDateInput && item.purchase_date) purchaseDateInput.value = item.purchase_date;
          });
          suggestionBox.appendChild(div);
        });
        suggestionBox.style.display = 'block';
        suggestionBox.style.width = nameInput.offsetWidth + 'px';
      });
  });

  // Hide suggestions on blur
  nameInput.addEventListener('blur', function() {
    setTimeout(function() { suggestionBox.style.display = 'none'; }, 150);
  });
}

document.addEventListener('DOMContentLoaded', initProductAutocomplete);
document.addEventListener('turbo:load', initProductAutocomplete);
document.addEventListener('DOMContentLoaded', flagBrokenImages);
document.addEventListener('turbo:load', flagBrokenImages);