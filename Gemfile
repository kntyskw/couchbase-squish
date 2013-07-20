source 'http://rubygems.org'

# Rails 3.1, Asset Pipeline and Javascript
gem 'rails', '3.1.0'
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end
gem 'jquery-rails'

# Required to give an executable JS environment
# in Production on Heroku
group :production do
  gem 'therubyracer', '0.9.9'
end

# Development / Test only.
group :development, :test do
  gem 'ruby-debug19', :platforms => :ruby_19
  gem 'ruby-debug', :platforms => :ruby_18
  gem 'foreman'
end
group :test do
  gem 'turn', :require => false
end
group :development do
  gem 'thin'
end

# Squish Application Dependencies
gem "couchbase"
gem "couchbase-model"
gem "validate_url"


