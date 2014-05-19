$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hello/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hello"
  s.version     = Hello::VERSION
  s.authors     = ["James Pinto"]
  s.email       = ["tjamespinto@gmail.com"]
  s.homepage    = "http://github.com/hi/hello"
  s.summary     = "Rails 4.* authentication solution"
  s.description = "Rails 4.* authentication solution"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4", "< 5"
  s.add_dependency "validates_email_format_of", '~> 1.5.3' # October 12, 2011
  s.add_dependency "before_actions"
  s.add_dependency "colorize"
  s.add_dependency "bcrypt"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'


  # save_and_open_page
  s.add_development_dependency 'launchy'
end
