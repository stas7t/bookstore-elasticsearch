# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.1'

gem 'dotenv-rails', require: 'dotenv/rails-now'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', '~> 0.12.3', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# JavaScript
gem 'webpacker'

group :development, :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'pry', '~> 0.12.2'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.6', '>= 3.6.1'
end

group :development do
  gem 'letter_opener', '~> 1.4', '>= 1.4.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '0.56.0', require: false

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '>= 3.3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0', '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 2.15', '>= 2.15.2'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
end

group :production do
  # gem 'bonsai-elasticsearch-rails', '~> 6'
  gem 'rails_12factor'
  gem 'railties'
  gem 'sendgrid-ruby'
end

gem 'ffaker', '~> 2.7'

gem 'sekrets'

# Rails Internationalization
gem 'rails-i18n', '~> 5.0.0'

# Authentication
gem 'devise', '>= 4.6.0'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-rails_csrf_protection'

# authorization
gem 'cancancan', '~> 2.0'

# Admin panel
gem 'rails_admin', '>= 1.3'

# Paginator
gem 'kaminari', '~> 1.2'

# Solution for file uploads
gem 'carrierwave', '~> 1.2'
gem 'fog-aws', '~> 1.4'

gem 'letter_avatar'

# State machines for Ruby classes
# gem 'aasm'

# Step-By-Step Wizard Controllers
gem 'wicked', '~> 1.3', '>= 1.3.2'

# An interface to the ImageMagick and GraphicsMagick image processing libraries
gem 'mini_magick', '>= 4.9.4'

# Templating engine
gem 'haml', '~> 5.0', '>= 5.0.3'
gem 'haml-rails', '~> 1.0'

# Bootstrap
gem 'bootstrap-sass', '>= 3.4.1'

# Font
gem 'font-awesome-sass', '~> 4.7.0'

# Forms
gem 'country_select', '~> 3.1', '>= 3.1.1'
gem 'simple_form', '~> 5.0'
gem 'virtus', '~> 1.0', '>= 1.0.5'

# Search engine
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# Workers
gem 'sidekiq'

# Cashing
gem 'actionpack-action_caching'
gem 'redis-rails'
