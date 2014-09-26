require 'colorize'
require 'before_actions'
require 'validates_email_format_of'
require 'user_agent_parser'
require 'http_accept_language'
require 'rails-i18n'
require 'bcrypt'



require "hello/engine"
require "hello/configuration"



  require "hello/errors"
  require "hello/locales"
  require 'hello/user_agent'



    require "hello/rails/controller"
    require "hello/rails/helper"



module Hello

  def self.available_time_zones
    ActiveSupport::TimeZone.zones_map.values.map(&:name)
  end

end

Dir[File.join(File.expand_path('../../', __FILE__), "app/models/concerns/**/*.rb")].each { |f| require f }
Dir[File.join(File.expand_path('../../', __FILE__), "app/models/*.rb")].each { |f| require f }
