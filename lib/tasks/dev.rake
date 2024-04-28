task import_games: :environment do
  BoardGameGeekService.import_games
end

desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  require "faker"
  # Clear existing records
  Reservation.delete_all
  Event.delete_all
  User.delete_all

  # Create Users
  alice = User.create!(username: "Alice", email: "alice@example.com", password: "password", phone_number: "1234567890", location: "Chicago", bio: "Love strategy games!", pfp_url: Faker::Avatar.image)
  bob = User.create!(username: "Bob", email: "bob@example.com", password: "password", phone_number: "0987654321", location: "Chicago", bio: "DnD enthusiast!", pfp_url: Faker::Avatar.image)

  # Additional Users
  sample_bios = [
  "Passionate about all things gaming and always ready to challenge the status quo.",
  "Strategy games enthusiast with a knack for finding new ways to win.",
  "Board game lover and social butterfly, always looking for a group to play with.",
  "Adventure games are my jam! If you want to explore new worlds, I’m your player.",
  "Collector of vintage board games and lover of complex puzzles.",
  "Always ready for a game night with friends to unwind and have some fun.",
  "Chess master in training, and I love teaching newcomers the ropes!",
  "Gaming since I could walk, and always on the lookout for new challenges."
]
  8.times do
    User.create!(
      username: Faker::Internet.username(specifier: 5..10),
      email: Faker::Internet.email,
      password: "password",
      phone_number: Faker::PhoneNumber.cell_phone,
      location: Faker::Address.city,
      bio: sample_bios.sample,
      pfp_url: Faker::Avatar.image,
    )
  end

  users = User.all
  games = Game.all
  # List of famous places in Chicago with latitude and longitude
  places = [
    { name: "Statue of Liberty", address: "Liberty Island, New York, NY 10004" },
    { name: "Golden Gate Bridge", address: "Golden Gate Bridge, San Francisco, CA 94129" },
    { name: "The Space Needle", address: "400 Broad St, Seattle, WA 98109" },
    { name: "Walt Disney World Resort", address: "Walt Disney World Resort, Orlando, FL 32830" },
    { name: "The Alamo", address: "300 Alamo Plaza, San Antonio, TX 78205" },
    { name: "The Gateway Arch", address: "Gateway Arch, St. Louis, MO 63102" },
    { name: "Mount Rushmore", address: "13000 SD-244, Keystone, SD 57751" },
    { name: "The Freedom Trail", address: "139 Tremont St, Boston, MA 02111" },
    { name: "Faneuil Hall Marketplace", address: "4 S Market St, Boston, MA 02109" },
    { name: "Central Park", address: "New York, NY 10024" },
    { name: "Las Vegas Strip", address: "S Las Vegas Blvd, Las Vegas, NV 89109" },
    { name: "French Quarter", address: "French Quarter, New Orleans, LA 70116" },
    { name: "Yosemite National Park", address: "California, CA 95389" },
    { name: "Times Square", address: "Manhattan, NY 10036" },
    { name: "Universal Studios Hollywood", address: "100 Universal City Plaza, Universal City, CA 91608" },
    { name: "Disneyland Park", address: "1313 Disneyland Dr, Anaheim, CA 92802" },
    { name: "Waikiki Beach", address: "Waikiki, Honolulu, HI 96815" },
    { name: "Pearl Harbor National Memorial", address: "1 Arizona Memorial Place, Honolulu, HI 96818" },
    { name: "Grand Canyon National Park", address: "Arizona, 86023" },
    { name: "Yellowstone National Park", address: "Yellowstone National Park, WY 82190" },
    { name: "Mall of America", address: "60 E Broadway, Bloomington, MN 55425" },
    { name: "The White House", address: "1600 Pennsylvania Ave NW, Washington, DC 20500" },
    { name: "Bryce Canyon National Park", address: "Bryce Canyon, UT 84764" },
    { name: "Zion National Park", address: "Zion National Park, Springdale, UT 84767" },
    { name: "Hollywood Sign", address: "Los Angeles, CA 90068" },
    { name: "Empire State Building", address: "20 W 34th St, New York, NY 10001" },
    { name: "Rockefeller Center", address: "45 Rockefeller Plaza, New York, NY 10111" },
    { name: "Alcatraz Island", address: "San Francisco, CA 94133" },
    { name: "Pike Place Market", address: "85 Pike St, Seattle, WA 98101" },
    { name: "Voodoo Doughnut", address: "22 SW 3rd Ave, Portland, OR 97204" },
    { name: "Arches National Park", address: "Moab, UT 84532" },
    { name: "Cloud Gate", address: "201 E Randolph St, Chicago, IL 60602" },
    { name: "Art Institute of Chicago", address: "111 S Michigan Ave, Chicago, IL 60603" },
    { name: "Smithsonian National Air and Space Museum", address: "600 Independence Ave SW, Washington, DC 20560" },
    { name: "Kennedy Space Center", address: "SR 405, Titusville, FL 32899" },
    { name: "Pike's Peak", address: "5089 Pikes Peak Highway, Cascade, CO 80809" },
    { name: "Biltmore Estate", address: "1 Lodge St, Asheville, NC 28803" },
    { name: "Myrtle Beach", address: "Myrtle Beach, SC 29577" },
    { name: "Acadia National Park", address: "Maine, ME 04609" },
    { name: "Lincoln Memorial", address: "2 Lincoln Memorial Cir NW, Washington, DC 20037" },
    { name: "Willis Tower", address: "233 S Wacker Dr, Chicago, IL 60606", latitude: 41.878876, longitude: -87.635915 },
    { name: "Navy Pier", address: "600 E Grand Ave, Chicago, IL 60611", latitude: 41.891709, longitude: -87.609281 },
    { name: "Millennium Park", address: "201 E Randolph St, Chicago, IL 60602", latitude: 41.882552, longitude: -87.622551 },
    { name: "Wrigley Field", address: "1060 W Addison St, Chicago, IL 60613", latitude: 41.948438, longitude: -87.655333 },
    { name: "The Field Museum", address: "1400 S Lake Shore Dr, Chicago, IL 60605", latitude: 41.866261, longitude: -87.617509 },
    { name: "Shedd Aquarium", address: "1200 S Lake Shore Dr, Chicago, IL 60605", latitude: 41.867573, longitude: -87.614038 },
    { name: "Adler Planetarium", address: "1300 S Lake Shore Dr, Chicago, IL 60605", latitude: 41.866333, longitude: -87.606782 },
  ]
  # Generate Events
  30.times do
    place = places.sample
    event = Event.create!(
      title: "#{Faker::Game.genre} Night",
      description: "Join us at #{place[:name]}",
      date_time: Faker::Time.forward(days: 14),
      location: place[:address],
      capacity: rand(1..6),
      host: users.sample,
      game: games.sample
    )

    # Attempt to geocode each event after creation
    result = CustomGeocoder.geocode(event.location)
    if result
      event.update(latitude: result["lat"], longitude: result["lng"])
    else
      puts "Failed to geocode address: #{event.location}"
    end
  end

  # Generate Reservations
  Event.all.each do |event|
    unless event.reservations.where(sender: User.all.sample).exists?
      Reservation.create!(
        event: event,
        sender: User.all.sample,
        status: ["yes", "maybe"].sample,
      )
    end
  end

  puts "Sample data generated successfully!"
  puts users
end
