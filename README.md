# wdi-project2
###Project 2 - randezvo.us

####Overview
randezvo.us is a crowd-sourced social mapping application built on Ruby on Rails. Users can add events to a map, gauge an event's popularity via votes, and choose to attend an event for that night. Users can also tag events to make them searchable on the map. There is also a social component to the app. Users can follow one another, like Twitter, and see events that other users have attended. Overall, randezvo.us can be used by someone new to an area looking for places to go or avoid or groups needing to form a consensus on a place and time to meet.

####Approach
I programmed this app (trying) to use the following workflow:
1. Design database schema and produce ERDs
2. Design wireframes
3. Build models and relations per the database schema
4. Build controllers necessary to carry out sought functionality
5. Build views consistent with wireframes

Ultimately, I deviated from this approach and developed the app in a piecemeal fashion. I found that I often would get caught down rabbit holes for things that are non-essential to the app's purpose. I think in the next go-around I will rely on TDD to guide my development process, mainly so I slow down and don't build superfluous features that detract from the app's overall goal.

####Technologies Used
#####Rails, ActiveRecord, psql
First and foremost, this application was built on Rails, using ActiveRecord as the ORM framework and postgresql as the database.

The application consists of ~7 models, which includes associations between Users, Events, Locations, Tags, and Votes. There are a few of many-to-many relationships (Follower/Followings, Tags/Events, Users/Events), which are handled using `has_many, through`. The Follower/Following relationship is self-referential, which I learned to implement using [this tutorial](https://www.railstutorial.org/book/following_users).

There are 4 controllers in the application, and most of the action happens in `events_controller.rb`. In `config/routes.rb`, I expanded on the default CRUD methods for events by adding methods to create and destroy attendances, vote on events, and add tags to events. I also added methods for follow/unfollow actions in `users_controller.rb`, which is a separate controller from devise's user controller.

There are a handful of views, but most of the action occurs in `events/index.html.erb`. Here, users get a list of all the events happening on the current day, and have the option to create events and add locations to the list of venues. The forms to create events/add locations are displayed as partial views. Other views to note are `events/show.html.erb` and `users/show.html.erb`.

#####Gems: `devise`, `geocoder`, `acts_as_votable`, `faker`
* `devise` was used to handle user authentication and collect user information. I added fields to the default devise options, so that the User could specify a username in addition to the default parameters.
* [`geocoder`](http://www.rubygeocoder.com/) was used to generate lat/lon coordinates for venue locations. It was really easy to implement- see `models/location.rb`.
* [`acts_as_votable`](https://github.com/ryanto/acts_as_votable) was used to add the voting mechanism to events, and allow users to vote on them. It also provided helper methods to tally up votes on events, check if a user has voted, and calculate the differential in votes.
* `faker` was used to generate seed data.

####Unsolved Problems
* The application crashes when no events are occurring on a given day. To bypass this, I wrote a conditional in the events controller, stating that if there are no events on a current day, return all the events. When nothing is returned, the map portion chokes up and nothing after that executes, which brings me to my next problem...
* All the javascript is written in the views. I knowingly did this so that I could mix `erb` with the js to create the geojson consumed by the map, but in production this leads to all kinds of syntax errors, crazy looking source code, and I get the feeling that it's a terrible practice. In the future, I would handle the data response in the controller and request it to the front-end using AJAX, but ultimately I fell short on time and felt that having it work hackily was better than it not working at all.
* As a user, I think that you can follow yourself. I tried to prevent this from happening in the user controller, but I'm not sure that it's caught.
* I would have liked for users to be able to add a new location in the same form that they create events, rather than in a separate form. I tried to nest a form within a form, but ran into issues, making me think that it's not possible. I think I would have to alter my model for this to work, but am unsure.
* When deploying to heroku, a css file for the token-input search (location input on `event#create` form) was causing a precompile error. To bypass this, I copied the contents of that file to `assets/stylesheets/application.scss`. Not sure why this was happening...
* I was having a hard time dealing with time variables in Ruby. Specifically using them to query events occuring on the present day. I found that `Time.now` returned times in the Eastern US timezone, while `created_at` is in UTC. I tried to change my environments to use Eastern US, but I'm not sure that worked. I ended up converting `Time.now` to UTC in the queries using time, but would have liked to avoid that all together by having all times in the same timezone. 

####Installation Instructions
* Fork and clone this repo.
* In your clone, run the following commands to get a version of the app up and running:
- `$ bundle install`
- `$ rake db:create db:migrate db:seed`
- `$ rails s`
* Go to `localhost:3000`. Your login credentials are `email@email.com` and `password`

####User Stories
1. As a user, I should be able to create an account so I can use the app.
2. As a user, I should be able to see events happening on the current day so I can decide where I want to go.
3. As a user, I should be able to attend an event so other users can expect to see me.
4. As a user, I should be able to filter events by tags so I can find things that interest me.
5. As a user, I should be able to tag an event so I can describe what's happening at a location.
6. As a user, I should be able to create an event so that others may join.
7. As a user, I should be able to follow another user so that I can see what events they've been to.
