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

  config.before(:each, type: :request) { host! 'api.example.com' }
end
