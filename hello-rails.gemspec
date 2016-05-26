$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hello/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hello-rails"
  s.version     = Hello::VERSION
  s.authors     = ["James Pinto", "Michal Papis"]
  s.email       = ["thejamespinto@gmail.com", "mpapis@gmail.com"]
  s.homepage    = "http://github.com/hello-gem/hello"
  s.summary     = "A Configurable Rails Authentication Engine"
  s.description = "Provides a set of valuable features for Registration, Authentication, Management and Internationalization."
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency "before_actions", '~> 2.0'
  s.add_runtime_dependency "colorize", '~> 0.7'
  s.add_runtime_dependency "user_agent_parser", '~> 2.3'
  s.add_runtime_dependency "http_accept_language", '~> 2.0'
  s.add_runtime_dependency "rails-i18n", '~> 4.0'

  s.add_development_dependency "sqlite3", '~> 1.3'
  s.add_development_dependency 'rspec-rails', '~> 3.4'
  s.add_development_dependency 'capybara', '~> 2.6'
  s.add_development_dependency 'email_spec', '~> 2.0'
  s.add_development_dependency 'factory_girl_rails', '~> 4.5'
  s.add_development_dependency 'faker', '~> 1.6'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0'
  s.add_development_dependency 'bdd', '~> 0.1'
  s.add_development_dependency 'bcrypt', '~> 3.1'
  s.add_development_dependency 'rubocop', '~> 0'
  s.add_development_dependency 'omniauth-facebook'

  # save_and_open_page
  s.add_development_dependency 'launchy', '~> 2.4'
end
