Geocoder.configure(
  lookup: :nominatim,         # use OpenStreetMap Nominatim API
  http_headers: { "User-Agent" => "GameNight" },  # Required by Nominatim's usage policy
  use_https: true,            # recommended for API calls
  timeout: 5                  # geocoding service timeout (in seconds)
)
