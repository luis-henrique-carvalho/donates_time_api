source 'https://rubygems.org'

ruby '3.2.0'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'devise'
gem 'devise-jwt'
gem 'jsonapi-serializer'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'pundit'
gem 'rack-cors'
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'ransack'
gem 'solid_queue'
gem 'tzinfo-data', platforms: %i[windows jruby]

# gem "jbuilder"
# gem "redis", ">= 4.0.1"
# gem "kredis"
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'annotate'
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-erd'
  gem 'rspec-rails'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.0'
  gem 'pundit-matchers'
  gem 'shoulda-matchers', '~> 4.5'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'simplecov_json_formatter', '~> 0.1.4', group: :test, require: false
end
