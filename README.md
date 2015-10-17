# Used University Text Book

Run Bundle install

Create setup_mail.rb in config/initializers and add the following lines:

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
	address:'smtp.sendgrid.net',
	port:'587',
	authentication: :plain,
	user_name: 'your username',
	password: 'your password',
	domain: 'heroku.com',
	enable_starttls_auto: true
}

start server with rails server
