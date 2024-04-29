require 'net/http'
require 'uri'
require 'json'

# Geocodes an address string returning the latitude and longitude. 
# Currently geocoding is not being used in present functionality but will be used in future iteraitons. 
class CustomGeocoder
  def self.geocode(address)
    api_key = ENV['MAP_API_KEY']
    base_url = "https://maps.googleapis.com/maps/api/geocode/json"
    url = URI("#{base_url}?address=#{URI.encode_www_form_component(address)}&key=#{api_key}")

    response = Net::HTTP.get_response(url)
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      if data['status'] == 'OK'
        return data['results'].first['geometry']['location']  # Returns { 'lat' => xx, 'lng' => yy }
      else
        raise "Geocoding error: #{data['status']}"
      end
    else
      raise "HTTP request error: #{response.message}"
    end
  end
end
