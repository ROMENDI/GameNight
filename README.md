# GameNight

GameNight is a board game meetup application designed to connect board game enthusiasts. It simplifies the process of finding player 
organizing meetups, and accessing a wider variety of games.

## Features

- **Profile Creation**: Users can create profiles. 
- **Event Browsing**: Browse upcoming board game events in your area.
- **Event Search**: Search for events based on location, and date.
- **RSVP to Events**: Easily RSVP to the events you want to attend.
- **Event Hosting**: Host your own events and manage event details such as date, time, location, and the games being played. 
- **Event Management**: Manage all of your hosted events and reserved events. 
- **Games Catalog**: View upcoming events for specific games. 

## Limitations

- **Games Database**: The games in the current games database is limited based on the current API being used. 
- **Geographic Coverage**: The application might initially have limited geographic coverage. Users in certain areas may not find many events or participants. 
- **Scalability**: The app's current backend infrastructure may not initially support a very high number of users or simultaneous event listings without performance degradation.

## Getting Started

These instructions will get you a copy of GameNight up and running on your local machine for development and testing.

1. **Clone the repository** 

   `git clone https://github.com/romendi/GameNight.git `

2. **Install dependencies**

  
    Install the necessary Ruby gems and node modules: `bundle install`

3. **Setup Database**

  
    Migrate your database: `rake db:migrate`

4. **Sample Data**

  
    Import games into database and generate sample data: `rake import_games` & `rake sample_data`

5. **Start the Server**

    Run the Rails server: `bin/dev`

6. **Visit the Application**

    Open your browser and go to: `http://localhost:3000`

## Contributing to GameNight

I welcome contributions. Here’s how you can contribute:

### Guidelines

- **Code Style**: Follow the [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide).
- **Commit Messages**: Write meaningful commit messages and include a reference to related issues if any.
- **Testing**: Add tests for new features and ensure that all tests pass before submitting a pull request.

### Submitting Pull Requests

1. Push your changes to your forked branch
2. Open a pull request against the main branch of the `GameNight` repository.
3. Describe your changes in detail in the pull request description.

### Branch Naming Conventions

**Use short, descriptive names for branches:**
- `feature/add_chess_game`
- `bugfix/login_issue`
- `docs/update_readme`

### Review Process

Contributions will be reviewed by me and feedback or approval will be given. 

## API Documentation

### BoardGameGeek API Interaction

This service utilizes the BoardGameGeek XML API2 for fetching board game data. Below is the description of the method used:

### Endpoint
- **GET** `https://boardgamegeek.com/xmlapi2/thing`

### Parameters
- `id` : A unique identifier for the game. This service iterates over a range of IDs to fetch multiple games.

### Response Format
- The response is in XML format. The service parses this XML to extract relevant game data like the title, description, and image URL.

### Example of Extracted Data
- **Title**: Extracted from the primary name node in the XML.
- **Description**: Plain text, extracted and cleaned of unnecessary encoding.
- **Image URL**: Direct URL to the game's image.

### Authentication
- The BoardGameGeek API does not require authentication for this type of request.

## FAQs / Troubleshooting

### Q1: What happens if the API call fails?
**A1**: The service logs an error message with the game ID and response code. No data will be saved for that game.

### Q2: How can I change the range of game IDs fetched?
**A2**: Modify the `game_ids` array in the `import_games` method to include the IDs you wish to fetch.

### Q3: What if I can't find a specific game in the catalog?
**A3**: Presently the games catalog is heavily limited. If you wish to add a new game, make a suggestion by contacting rohan.mendiratta01@gmail.com. 

### Q4: Is there a way to connect with other players before the event?
**A4**: Yes, each game night event has the profiles of the host as well as each of the reserved guests. Visit their profiles to view their contact details. 

### Q5: How do I submit a bug or feature request?
**A5**: To submit a bug or feature request, please use the GitHub Issues section of our repository. 
