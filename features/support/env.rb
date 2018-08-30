require 'cucumber/rails'
require 'factory_bot'

def load_fixture(filename)
  path = Rails.root.join('features', 'support', 'fixtures', filename)
  File.open(path, 'r', &:read)
end

World(FactoryBot::Syntax::Methods)
World(Rails.application.routes.url_helpers)

ActionController::Base.allow_rescue = false

begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation
