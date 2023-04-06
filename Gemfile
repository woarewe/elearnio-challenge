# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "bootsnap", ">= 1.4.4", require: false
gem "dotenv-rails", "~> 2.8", ">= 2.8.1", require: "dotenv/rails-now"
gem "dry-struct", "~> 1.6"
gem "dry-types", "~> 1.7.1"
gem "dry-validation", "~> 1.10"
gem "grape", "~> 1.7"
gem "grape-entity", "~> 1.0.0"
gem "grape-swagger", "~> 1.6"
gem "kaminari", "~> 1.2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.7", ">= 6.1.7.3"

group :test do
  gem "rspec", "~> 3.12"
  gem "rspec-rails", "~> 6.0", ">= 6.0.1"
end
group :development, :test do
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
