Geocoder.configure(
  lookup: :google,
  api_key: ENV['MAP_API_KEY'],  
  use_https: true,  
  units: :miles,  
)
