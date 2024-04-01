desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
    require 'faker'
    User.delete_all
    Event.delete_all
    Reservation.delete_all
    Game.delete_all

    User.create!(username: 'Alice', email: 'alice@example.com', password: 'password', phone_number: '1234567890', location: 'Chicago', bio: 'Love strategy games!', pfp_url: Faker::Avatar.image)
    User.create!(username: 'Bob', email: 'bob@example.com', password: 'password', phone_number: '0987654321', location: 'Chicago', bio: 'DnD enthusiast!', pfp_url: Faker::Avatar.image)
    # Generate Users
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

    # Generate Games
    5.times do
      Game.create!(
        title: Faker::Game.title,
        description: Faker::Lorem.sentence(word_count: 15),
        image_url: Faker::Internet.url
      )
    end

    # Ensure User and Game records exist
    users = User.all
    games = Game.all

    # Generate Events
    20.times do
      Event.create!(
        title: "#{Faker::Game.genre} Night",
        description: Faker::Lorem.paragraph(sentence_count: 2),
        date_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
        location: Faker::Address.full_address,
        capacity: rand(1..8),
        game: games.sample,
        host: users.sample
      )
    end

  # Generate Reservations
  50.times do
    Reservation.create!(
      event: Event.all.sample,
      sender: users.sample,
      status: ['yes', 'maybe'].sample
    )
  end

  puts "Sample data generated successfully!"
  puts users
  puts games 
end
