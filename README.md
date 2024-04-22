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

  
    Copy the sample environment file and set up your environment variables: `rake sample_data`

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
