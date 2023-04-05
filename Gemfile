# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "dotenv-rails", "~> 2.8", ">= 2.8.1", require: "dotenv/rails-now"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 6.1.7", ">= 6.1.7.3"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :test do
  gem "rspec", "~> 3.12"
  gem "rspec-rails", "~> 6.0", ">= 6.0.1"
end
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails", "~> 6.2.0"
  gem "faker", "~> 3.1.1"
  gem "rubocop", "~> 1.48", ">= 1.48.1", require: false
  gem "rubocop-performance", "~> 1.16", require: false
  gem "rubocop-rails", "~> 2.18", require: false
  gem "rubocop-rspec", "~> 2.19", require: false
end

group :development do
  gem "listen", "~> 3.3"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
