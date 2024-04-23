task import_games: :environment do
  BoardGameGeekService.import_games
end

desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  require 'faker'
  # Clear existing records
  Reservation.delete_all
  Event.delete_all
  User.delete_all

  # Create Users
  alice = User.create!(username: 'Alice', email: 'alice@example.com', password: 'password', phone_number: '1234567890', location: 'Chicago', bio: 'Love strategy games!', pfp_url: Faker::Avatar.image)
  bob = User.create!(username: 'Bob', email: 'bob@example.com', password: 'password', phone_number: '0987654321', location: 'Chicago', bio: 'DnD enthusiast!', pfp_url: Faker::Avatar.image)

  # Additional Users
  8.times do
    User.create!(
      username: Faker::Internet.username(specifier: 5..10),
      email: Faker::Internet.email,
      password: 'password', 
      phone_number: Faker::PhoneNumber.cell_phone,
      location: Faker::Address.city,
      bio: Faker::Lorem.sentence(word_count: 10),
      pfp_url: Faker::Avatar.image
    )
  end

  users = User.all
  games = Game.all
# List of famous places in Chicago with latitude and longitude
  chicago_places = [
    { name: "Willis Tower", address: "233 S Wacker Dr, Chicago, IL 60606", latitude: 41.878876, longitude: -87.635915 },
    { name: "Navy Pier", address: "600 E Grand Ave, Chicago, IL 60611", latitude: 41.891709, longitude: -87.609281 },
    { name: "The Art Institute of Chicago", address: "111 S Michigan Ave, Chicago, IL 60603", latitude: 41.879585, longitude: -87.623713 },
    { name: "Millennium Park", address: "201 E Randolph St, Chicago, IL 60602", latitude: 41.882552, longitude: -87.622551 },
    { name: "Wrigley Field", address: "1060 W Addison St, Chicago, IL 60613", latitude: 41.948438, longitude: -87.655333 },
    { name: "The Field Museum", address: "1400 S Lake Shore Dr, Chicago, IL 60605", latitude: 41.866261, longitude: -87.617509 },
    { name: "Shedd Aquarium", address: "1200 S Lake Shore Dr, Chicago, IL 60605", latitude: 41.867573, longitude: -87.614038 },
    { name: "Adler Planetarium", address: "1300 S Lake Shore Dr, Chicago, IL 60605", latitude: 41.866333, longitude: -87.606782 }
  ]
  # Generate Events
  10.times do |i|
    event = Event.create!(
      title: "#{Faker::Game.genre} Night #{i}",
      description: Faker::Lorem.sentence(word_count: 10),
      date_time: Faker::Time.forward(days: 23),
      location: "#{Faker::Address.street_address}, #{Faker::Address.city}",
      capacity: rand(5..20),
      host: users.sample
    )

    # Attempt to geocode each event after creation
    result = Geocoder.geocode(event.location)
    if result
      event.update(latitude: result['lat'], longitude: result['lng'])
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
          status: ['yes', 'maybe'].sample
        )
      end
    end

  puts "Sample data generated successfully!"
  puts users
end
