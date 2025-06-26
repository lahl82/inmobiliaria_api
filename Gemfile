# typed: strict
# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Core Gems
gem 'rails', '~> 7.1', '>= 7.1.5.1'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.6'
gem 'rack', '~> 3.1'
gem 'rack-cors', '~> 2.0'

# State management
gem 'aasm', '~> 5.5'

# File Uploads
gem 'activestorage', '~> 7.1.5'
gem 'active_storage_base64', '~> 3.0'
gem 'image_processing', '~> 1.14'
gem 'aws-sdk-s3', '~> 1.183', require: false

# Background helpers and performance
gem 'bootsnap', '~> 1.18', require: false
gem 'dotenv-rails', '~> 3.1'
gem 'kaminari', '~> 1.2'

# Authentication and Authorization
gem 'devise', '~> 4.9'
gem 'devise-jwt', '~> 0.12'

# JSON Serialization
gem 'blueprinter', '~> 1.1', '>= 1.1.2'
# gem 'jbuilder' # Reemplazado por Blueprinter

# Platform-specific dependency for Windows
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # Debugging & Testing Tools
  gem 'awesome_print', '~> 1.9'
  gem 'byebug', '~> 12.0'
  gem 'debug', '~> 1.10', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.5'
  gem 'i18n-tasks', '~> 1.0.15'
  gem 'rspec-rails', '~> 7.1'
end

group :development do
  # Formatting & Style Tools
  gem 'prettier', '~> 4.0' # Linter para longitudes de línea
  gem 'solargraph', '~> 0.54'

  # Ruby LSP (para editores compatibles con LSP como VSCode)
  gem 'ruby-lsp', '~> 0.23', require: false
  gem 'ruby-lsp-rails', '~> 0.4', require: false
  gem 'ruby-lsp-rspec', '~> 0.1', require: false

  # RuboCop (estilo y convenciones)
  gem 'rubocop', '~> 1.75'
  gem 'rubocop-performance', '~> 1.25'
  gem 'rubocop-rails', '~> 2.31'
  gem 'rubocop-rspec', '~> 3.6'

  # gem 'spring' # Speed up boot time on some systems
end

group :test do
  gem 'shoulda-matchers', '~> 6.4'
  gem 'simplecov', '~> 0.22'
end
