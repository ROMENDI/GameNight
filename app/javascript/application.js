// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener('DOMContentLoaded', () => {
  const script = document.createElement('script');
  script.src = `https://maps.googleapis.com/maps/api/js?key=${process.env.MAP_API_KEY}&libraries=places&callback=initMap`;
  script.async = true;
  document.body.appendChild(script);
});

function initMap() {
  const input = document.getElementById('autocomplete');
  const autocomplete = new google.maps.places.Autocomplete(input);
}
