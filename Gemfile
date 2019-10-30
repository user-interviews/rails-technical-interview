source 'https://rubygems.org'

# Ruby
ruby '~> 2.4.3' # This appears to be the max version of ruby we can use for Rails 4.2.x

# Rails
gem 'rails', '4.2.10' # Set exact version of rails

# Core
gem 'bcrypt', '~> 3.1' # ActiveModel has_secure_password
gem 'pg', '~> 0.21' # Last postgres version usable by ActiveRecord 4.2.10

# Asset Pipeline
gem 'sass-rails', '~> 5.0' # SCSS support
gem 'sprockets', '~> 3.7' # Asset pipeline
gem 'sprockets-rails', '~> 3.0' # Asset pipeline
gem 'uglifier', '~> 4.1' # JS Minification

# JS Gems
gem 'jquery-rails', '~> 4.3' # jquery 1, 2, 3 support
gem 'jquery-ui-rails', '~> 6.0' # jquery UI support
gem 'react-rails', '~> 2.4.0' # Allows us to use React in the asset pipeline

# Style Gems
gem 'autoprefixer-rails', '~> 6.0' # apply vendor css prefixes
gem 'bootstrap', '~> 4.0' # SCSS bootstrap support
gem 'font-awesome-rails', '~> 4.7' # font icons support

# Utilities
gem 'unicorn-rails', '2.1.1' # app server

group :development do
  gem 'rubocop', '~> 0.52.0', require: false # Linting
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara', '~>2.17' # UI Testing from Rails
  gem 'factory_bot_rails', '~>4.8' # Test mock framework
  gem 'nokogiri', '~> 1.10' # XML Parsing
  gem 'timecop', '~>0.9' # Freeze test time
end

group :development, :test do
  gem 'jasmine-rails', '~> 0.14' # toolkit for testing react
  gem 'rspec-rails', '~>3.7' # Test runners
end

group :production do
  gem 'rails_12factor', '0.0.2' # https://github.com/heroku/rails_12factor
end
