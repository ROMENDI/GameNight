require "httparty"
require "nokogiri"

class BoardGameGeekService
  def self.import_games
    Reservation.delete_all
    Event.delete_all
    Game.delete_all
    User.delete_all
    game_ids = (1..50).to_a
    # Iterates through each game ID and fetches data from the API.
    game_ids.each do |game_id|
      response = HTTParty.get("https://boardgamegeek.com/xmlapi2/thing?id=#{game_id}")

      if response.success?
        parsed_response = Nokogiri::XML(response.body)
        extract_game_data(parsed_response)
      else
        puts "Error fetching game data for ID #{game_id}: #{response.code}"
      end
    end
  end

  # Extracts and saves game data from the XML response.
  def self.extract_game_data(parsed_response)
    primary_name_node = parsed_response.xpath("//item/name[@type='primary']").first
    game_title = primary_name_node ? primary_name_node["value"] : "Unknown Title"
    game_image_url = parsed_response.xpath("//item/image").text
    game_description = parsed_response.xpath("//item/description").text.gsub("&#10;", " ").squeeze(" ")

    game = Game.new(title: game_title, description: game_description, image_url: game_image_url)
    game.save
  end
end
