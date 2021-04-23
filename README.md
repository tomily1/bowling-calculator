# README
[![Build Status](https://travis-ci.com/tomily1/bowling-calculator.svg?branch=master)](https://travis-ci.com/tomily1/bowling-calculator)

A simple API for recording bowling game scores and the overall scores

### Requirements
1. Ruby version 2.7.1
2. Rails 5.2
3. Bundler version 2.1.4
4. Sidekiq version 6.2
5. Redis


### Technology used
* Language
  1. Ruby
* Framework used
  1. Ruby on Rails
* Development and testing
  1. RSpec Rails
  2. Rubocop
* Database
  1. PostgreSQL
  2. Redis

### Setting up
1. clone this respository `git clone git@github.com:tomily1/bowling-calculator.git`.
2. Open the cloned directory with `cd bowling-calculator`.
3. Run `bundle install` to install dependencies
4. Run `bundle exec sidekiq` (Make sure you have redis running)

On another terminal run the following in the project directory

5. Run `rails db:setup` to setup the database (N.B postgresql is used for database)
6. Run `rails db:seed` to load the database with sample data
7. Run the app with `rails server`
8. The app will be available on `localhost:3000`

### Endpoints

#### User create
```
Request: POST "/v1/users"
Header: Content-Type: application/json

Parameters:
  body: { name: 'test' }

Response: 
{
    "name": "test",
    "game_id": 6
}
```

**N.B: Game gets automatically created on user creation**

#### User update
Updates the user data

```
Request: PUT "/v1/users/:id"
Header: Content-Type: application/json

Parameters: 
  body: { name: 'test' }

Response: 
{
  "name": "test",
  "game_id": 6
}
```

#### User delete
deletes the user data and game

```
Request: DELETE "/v1/users/:id"
Header: Content-Type: application/json

Parameters: 

Response: 
200 OK
```



#### Game update
Adds the knocked pins

```
Request: PUT "/v1/games/:id"
Header: Content-Type: application/json

Parameters: 
  body: { "game": { "pins": "x" } }

Response: 
{
  "game_id": 6
}
```

#### Game score

Fetches the game score

```
Request: GET "/v1/games/:id"
Header: Content-Type: application/json

Response: 
{
    "score": 181,
    "game_id": 5
}
```
