source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use sqlite3 as the database for Active Record
gem 'pg',	'0.18.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass', '~> 3.3.5'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
#authentication gem
gem 'devise', '3.5.2'
gem 'omniauth-facebook', '3.0.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-bootstrap', '1.0.1'
gem 'font-awesome-rails', '4.5.0.1'
gem 'carrierwave', '0.10.0'
gem 'mini_magick', '4.4.0'
gem 'fog', '1.37.0'
gem 'sidekiq', '4.1.1'
gem 'faker', '1.6.3'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'https://github.com/yuanxue68/Used-Book.git

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :development do
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug'
	gem 'spring'
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem 'shoulda-matchers', '~> 3.1.1'
end

group :test do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'database_cleaner', '~> 1.5', '>= 1.5.1'
  gem 'factory_girl_rails', '~> 4.6'
	gem 'guard'
  gem 'capybara'  
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
end

group :production do
	gem 'rails_12factor', '0.0.3'
end
