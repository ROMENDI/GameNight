function initAutocomplete() {
  var input = document.getElementById('autocomplete');
  var autocomplete = new google.maps.places.Autocomplete(input);

  autocomplete.setFields(['address_components', 'geometry', 'name']);
  autocomplete.addListener('place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      window.alert("No details available for input: '" + place.name + "'");
      return;
    }
  });
}

document.addEventListener("turbolinks:load", initAutocomplete);
