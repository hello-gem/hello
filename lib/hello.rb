require 'colorize'

require_relative 'hello/engine'
require_relative 'hello/configuration'

module Hello
  def self.root
    @root ||= Pathname(File.dirname(__FILE__)).join('..')
  end

  def self.warning(s2)
    s1 = 'HELLO DEV WARNING:'.black.on_yellow.bold
    puts "#{s1} #{s2.yellow}"
  end

  autoload :Business,          'hello/business'
  autoload :TimeZones,         'hello/time_zones'
  autoload :Encryptors,        'hello/encryptors'
  autoload :RailsActiveRecord, 'hello/rails_active_record'
  autoload :RailsController,   'hello/rails_controller'
  autoload :RailsHelper,       'hello/rails_helper'
  autoload :Errors,            'hello/errors'
  autoload :Utils,             'hello/utils'
  autoload :Middleware,        'hello/middleware'
  autoload :Locales,           'hello/locales'
  autoload :RequestManager,    'hello/request_manager'
end

if defined? Rails
  require 'before_actions'
  require 'http_accept_language'
  require 'rails-i18n'

  ActionView::Base.include Hello::RailsHelper
  ActionController::Base.include Hello::RailsController
end
