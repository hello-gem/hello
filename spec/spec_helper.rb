ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

# require 'rspec/rails'
# require 'rspec/autorun'
# require 'factory_girl_rails'
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
SPEC_ROOT=File.dirname(__FILE__)
Dir[File.join(SPEC_ROOT, "support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  # config.order = "random"
end

