source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "bcrypt", "~> 3.1", ">= 3.1.12"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
  gem "guard", "~> 2.19", ">= 2.19.1"
  gem "guard-rspec", "~> 4.7", ">= 4.7.3"
  gem "guard-rubocop", "~> 1.5"
end

group :test do
  gem "rspec-rails", "~> 8.0"
  gem "factory_bot_rails"
  gem "rails-controller-testing", "~> 1.0", ">= 1.0.5"
  gem "simplecov", require: false
  gem "shoulda-matchers", "~> 6.5"
end
