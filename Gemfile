# typed: strict
# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '3.2.2'

gem 'aasm'
gem 'activestorage', '~> 7.1.0'
gem 'active_storage_base64', '~> 3.0.0'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', require: false
gem 'devise'
gem 'devise-jwt'
gem 'dotenv-rails', groups: %i[development test]
gem 'image_processing', '>= 1.12'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'pg'
gem 'puma'
gem 'rack'
gem 'rack-cors'
gem 'rails', '~> 7.1.0'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'awesome_print'                         # Pretty print your Ruby objects with indentation
  gem 'byebug'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'prettier'                              # Linting tool specifically for line length warnings
  gem 'ruby-lsp', require: false
  gem 'ruby-lsp-rails', require: false
  gem 'ruby-lsp-rspec', require: false

  gem 'rubocop'                               # Style Monitoring
  gem 'rubocop-performance'                   # Performance Monitoring
  gem 'rubocop-rails'                         # Rails Style Monitoring
  gem 'rubocop-rspec'                         # Rspec Style Monitoring
  gem 'solargraph'
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov'
end
