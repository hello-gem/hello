def get_code_climate_token
  travis_yml = "#{SPEC_ROOT}/../.travis.yml"
  travis_hash = YAML.load_file(travis_yml)
  travis_hash['addons']['code_climate']['repo_token']
end

ENV['CODECLIMATE_REPO_TOKEN'] ||= get_code_climate_token
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start



ENV['RAILS_ENV'] ||= 'test'

SPEC_ROOT=File.dirname(__FILE__)

require File.expand_path("../dummy/config/environment.rb",  __FILE__)



# require 'rspec/rails'
# require 'rspec/autorun'
require 'factory_girl_rails'
require 'faker'
# require "rails/test_help"

require 'rspec/rails'
require 'capybara/rails'
require "email_spec"


# https://github.com/bmabey/email-spec#rspec
# https://github.com/bmabey/email-spec#rspec-1

BCrypt::Engine.cost = 1


Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir[File.join(SPEC_ROOT, "support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)





RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  # config.order = "random"

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
end

