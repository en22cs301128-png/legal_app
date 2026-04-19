source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.9"

gem "rails", "~> 7.1.0"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

group :development, :test do
  gem "rspec-rails", "~> 6.0"
  gem "factory_bot_rails"
  gem "faker"
  gem "byebug"
end

group :test do
  gem "shoulda-matchers", "~> 5.0"
  gem "database_cleaner-active_record"
end
