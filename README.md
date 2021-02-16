![Meal Manager](https://i.imgur.com/PRPO2JL.png)
---
# Table of Contents
- [Problem](#problem)
- [Solution](#solution)
- [Features](#features)
- [Technologies](#technologies)
- [Usage](#usage)
# Problem
The current system used in our chapter is ineffective. It involves copying and pasting from a google document that holds all the recipes, adding up the ingredient manually, and assigning the pickup locations from memory. It is a tedious and boring task that often results in an error when an ingredient is forgotten to be added to the shopping list. This can often result in having to go shopping outside of normal shopping days making it inconvenient for members of the chapter. 

# Solution
This system allows the user to generate a menu and shopping list within minutes. The user can create a menu for either this week or the next week. This is done by selecting the meals from a dropdown and generating the shopping list. After purchasing the ingredient, the receipts can be added to keep track of finances for the food committee.

This repo contains the backend API used by the meal manager. It is a RESTful API that is used to serve the [Ember.js front-end](https://github.com/dca123/food-web). The data is stored in a PostgreSQL database hosted along with the backend. 

# Features
-   Create and update menus up to two weeks
-   Create and update meals from the database along with ingredients
-   Generate shopping lists ordered by location and type of ingredient
-   Add receipts
-   Keep track of finances by week and semester
# Technologies
- [Ruby on Rails](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
# Usage
1. Install dependenciens
```ruby
bundle install
```
2. Setup database
```ruby
bundle exec rake db:create
bundle exec rake db:setup
```
Seed with random data (optional)
```ruby
bundle exec rake db:seed
```
 3. Start Server
 ```ruby
 bundle exec rails s
```
