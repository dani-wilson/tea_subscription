# Tea Subscription

Tea Subscription is a mock take-home challenge during module 4 of Turing School of Software & Design's software engineering program, wherein the student is expected to complete the MVP in no more than 8 hours.

## About the Project
This application is a web application designed to produce APIs. The application utilizes Ruby on Rails, with a PostgrSQL database.

### Built With
- [Ruby 3.2.2](https://github.com/ruby/ruby)
- [Rails 7.0.8](https://github.com/rails/rails)
- [postgresql](https://github.com/postgres/postgres)

### Getting Started
To use Tea Subscription locally, you can fork and clone [this](https://github.com/dani-wilson/tea_subscription) repo

### Configuration
1. Clone this repo
2. cd into the directory where it was cloned and launch code editor
3. run `bundle install` to install gems and dependencies
4. Run `rails db:{create,migrate,seed}` to setup and seed the database

  ### Testing
  To test the full suite, run `bundle exec rspec`
  To see a full coverage report with SimpleCov, use `open coverage/index.html`

  ### Endpoint use
  Endpoints can be tested in Postman using localhost:3000<br>
  Endpoints are as follows:
  1. Create a tea subscription for a customer<br>
    - POST /api/v0/subscriptions<br>
    - example of params:<br><br>
     subscription_params = ({<br>
        title: Biweekly Orange Rooibos,<br>
        price: 12.50,<br>
        status: 0,<br>
        frequency: Biweekly,<br>
        customer_id: [known customer id],<br>
        tea_id: [known tea id]<br>
      })<br><br>
    

  2. Delete a customer's tea subscription<br>
    - DELETE /api/v0/subscriptions/{{subscription_id}}</br>
    
  3. Get all tea subscriptions<br>
    - GET /api/v0/subscriptions
