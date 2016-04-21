require DUMMY_ROOT.join('config/environment.rb')

require 'factory_girl_rails'
require 'faker'
require 'rspec/rails'
require 'capybara/rails'
require 'email_spec'
require 'bdd'

# silencers
Rails.backtrace_cleaner.remove_silencers!

# deprecation
ActiveSupport::Deprecation.silenced = true

# quiet migrations
ActiveRecord::Schema.verbose = false
