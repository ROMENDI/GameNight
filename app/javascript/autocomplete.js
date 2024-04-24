
document.addEventListener("turbolinks:load", function() {
  var input = document.getElementById('autocomplete');
  if (!input) return;

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.setFields(['address_components', 'geometry', 'formatted_address']);

  autocomplete.addListener('place_changed', function() {
      var place = autocomplete.getPlace();
      if (!place.geometry) {
          alert("No details available for input: '" + place.name + "'");
          return;
      }
      console.log(place.geometry.location.lat());
      console.log(place.geometry.location.lng());
  });
});
