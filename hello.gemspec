$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hello/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hello"
  s.version     = Hello::VERSION
  s.authors     = ["James Pinto"]
  s.email       = ["tjamespinto@gmail.com"]
  s.homepage    = "http://github.com/hello-gem/hello"
  s.summary     = "Rails Gem to authenticate you and your users"
  s.description = "We want enjoyable Rails authentication"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.test_files = Dir["spec/**/*"]


  s.add_runtime_dependency 'rails', '>= 3.0.0'
  s.add_runtime_dependency 'bcrypt'
  s.add_runtime_dependency "validates_email_format_of"
  s.add_runtime_dependency "before_actions"
  s.add_runtime_dependency "colorize"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'


  # save_and_open_page
  s.add_development_dependency 'launchy'
end
