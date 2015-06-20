ENV['RAILS_ENV'] ||= 'test'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start



SPEC_ROOT=File.dirname(__FILE__)

require File.expand_path("../dummy/config/environment.rb",  __FILE__)


ActiveSupport::Deprecation.silenced = true

# require 'rspec/rails'
# require 'rspec/autorun'
require 'factory_girl_rails'
require 'faker'
# require "rails/test_help"

require 'rspec/rails'
require 'capybara/rails'
require "email_spec"
require 'bdd'


# https://github.com/bmabey/email-spec#rspec
# https://github.com/bmabey/email-spec#rspec-1

BCrypt::Engine.cost = 1


Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir[File.join(SPEC_ROOT, "support/**/*.rb")].each { |f| require f }




#
# Multiple Gemfiles
#
puts "Testing against version #{Rails::VERSION::STRING}".magenta
# database: ":memory:"
puts "creating sqlite in memory database"
ActiveRecord::Schema.verbose = false
load "#{Rails.root}/db/schema.rb"





RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  # config.order = "random"

  config.infer_spec_type_from_file_location!
  
  config.include Hello::FeatureSupportGiven, type: :feature
  config.include Hello::RequestSupport, type: :request

  config.include FactoryGirl::Syntax::Methods

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  config.before(:each) { I18n.locale = :en }
end

