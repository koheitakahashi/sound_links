# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

# default
gem "rails", "6.1.3.2"
# gem "sqlite3", "~> 1.4"
gem "puma", "~> 4.3.8"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 4.0"
# gem "turbolinks", "~> 5"
gem "bootsnap", ">= 1.4.2", require: false

# not default
gem "jwt"
gem "faraday"
gem "sprockets", "< 4"
gem "meta-tags"
gem "pg"
gem "kaminari"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # not default
  gem "rubocop", require: false
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"

  # not default
  gem "rspec-rails", "~> 5.0.0"
  gem "factory_bot"
  gem "webmock"
  gem "simplecov", require: false
end
