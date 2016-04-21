ENV['RAILS_ENV'] ||= 'test'
SPEC_ROOT  = Pathname(File.dirname(__FILE__))
DUMMY_ROOT = SPEC_ROOT.join('../dummy')

require 'spec_helper/codeclimate' # this should be atop all
require 'spec_helper/dummy_and_test_dependencies'
require 'spec_helper/support'
require 'spec_helper/create_database'
require 'spec_helper/configure_rspec'
