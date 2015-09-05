source 'https://rubygems.org'
ruby File.read('.ruby-version').strip


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'ffaker'
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers', require: false
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'simplecov', :require => false
end
# assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'haml'

group :production do
  # Use postgres in production
  gem 'pg'
  # required for full dokku features
  gem 'rails_12factor'
end

# CORS yay
gem 'rack-cors', :require => 'rack/cors'
# Use rails admin for managing resources
gem 'rails_admin'
# user devise for authentication
gem 'devise'
# Use puma as the app server
gem 'puma'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

