# Tec Tec
Site for auctioning used books
[Demo on free tier Heroku](http://floating-mesa-3668.herokuapp.com/) 

### How to run it on your local machine
######After you clone the repository:
This project uses PostgreSQL
Create all the databases specifield in database.yml
```ruby
rake db:create:all
```

Install all the required gems
```ruby
Bundle install
```

add the following lines in environment.rb:

```ruby
ActionMailer::Base.smtp_settings = {
	address:'smtp.sendgrid.net',
	port:'587',
	authentication: :plain,
	user_name: 'your username',
	password: 'your password',
	domain: 'your server domain',
	enable_starttls_auto: true
}
```

Start the server on port 3000
```ruby
redis-server         #start up redis
rails server         #start up rails server
bundle exec sidekiq  #start up sidekiq
```

###Build Status
[ ![Codeship Status for yuanxue68/Used-Book](https://codeship.com/projects/ba052990-56a9-0133-5c51-5ebc52a48109/status?branch=master)](https://codeship.com/projects/109413)

