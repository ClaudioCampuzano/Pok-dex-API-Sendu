# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.2"

gem "bootsnap", require: false
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.1"
gem "sqlite3", "~> 1.4"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development do
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem "factory_bot_rails"
  gem "faker"
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop-rails'
end
