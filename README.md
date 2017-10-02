
# Developer Notes
## Routes
QuestionsController is routed to //api/v1/questions
#show (obviously) routes to //api/v1/question/<id>

## API Key

The Api Key can be either a basic auth (e.g. api:< key >@localhost:3000/api/v1/questions)
or a query string (e.g. localhost:3000/api/v1/questions?api_key=< key>)
a key which doesn't exist in the tenants table will return a 401 "Access Denied"
## API counter
The assignment didn't specify whether or how to display the counter, so for now,
the examiner should use rails console:

```ruby
Tenant.first.api_count
```

(assuming that was the api key used in testing)

## Test Coverage
I used FactoryGirl mostly out of habit, but if the scope was really as limited as this example, I wouldn't bother.
The only tests I wrote were in spec/controllers/questions_controller_spec, as that was the only controller/route that I wrote substantive code for.

## Database
Please don't forget to run >`rake db:setup`

----
# Batteries 911 Rails Engineer Candidate Interview Project

(This is a fork of the [Kaleo Rails Engineer Candidate Interview Project](https://github.com/batteries911/rails-interview-project).)

Thanks for taking the time to complete this exercise. We're excited that you're considering joining our amazing team.

This Rails application is a basic skeleton of an app that serves an API about questions and answers. It already includes 4 basic models:

1.  Question
2.  Answer
3.  User
4.  Tenant

A Question can have one or more answers, and can be private. Every Answer belongs to one question. Each Question has an asker (User), and each Answer has a provider (User).

A Tenant is a consumer of the API you are going to write. A db/seeds.rb file is included to preload the database with test data when you setup the DB.

## You need to accomplish the following tasks:

*   Add a RESTful, read-only API to allow consumers to retrieve Questions with Answers as JSON (no need to retrieve Answers on their own). The response should include Answers inside their Question as well as include the id and name of the Question and Answer users.
*   Don't return private Questions in the API response.
*   Require every API request to include a valid Tenant API key, and return an HTTP code of your choice if the request does not include a valid key.
*   Track API request counts per Tenant.
*   Add tests around the code you write as you deem appropriate. Assume that the API cannot be changed once it's released and test accordingly.
*   You are welcome to add any models or other code you think you need, as well as any gems.
*   You are also free the modify the existing code however you see fit.

## Project Setup

Clone this repo locally, and from the top-level directory run:

`bundle install`

`bundle exec rake db:setup`

To make sure it's all working,

`rails s`

You should see this same information.

## Submitting your project

Fork this repo and give us access to your fork.  If you need to add any additional instructions to the README please put them at the very top of that file and mention.  Expect to discuss your design decisions during the interview.
