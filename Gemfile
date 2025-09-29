# frozen_string_literal: true

source "https://rubygems.org"

gem "hanami", github: "hanami/hanami", branch: "main"
gem "hanami-assets", github: "hanami/assets", branch: "main"
gem "hanami-controller", github: "hanami/controller", branch: "main"
gem "hanami-db", github: "hanami/db", branch: "main"
gem "hanami-router", github: "hanami/router", branch: "main"
gem "hanami-validations", github: "hanami/validations", branch: "main"
gem "hanami-view", github: "hanami/view", branch: "main"

gem "dry-types", "~> 1.7"
gem "dry-operation"
gem "puma"
gem "rake"
gem "sqlite3"

group :development do
  gem "hanami-webconsole", "~> 2.2"
end

group :development, :test do
  gem "dotenv"
end

group :cli, :development do
  gem "hanami-reloader", "~> 2.2"
end

group :cli, :development, :test do
  gem "hanami-rspec", "~> 2.2"
end

group :test do
  # Database
  gem "database_cleaner-sequel"

  # Web integration
  gem "capybara"
  gem "rack-test"
end
