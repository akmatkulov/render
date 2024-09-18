# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.2.1'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem "factory_bot_rails"


group :development, :test do
  gem "ffaker"
  gem 'shoulda-matchers', '~> 6.0'
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'rspec-rails', '~> 7.0.0'
  gem 'rubocop-rspec_rails', require: false
end

group :development do
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'
end
