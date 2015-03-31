require 'colorize'
require 'before_actions'
require 'validates_email_format_of'
require 'user_agent_parser'
require 'http_accept_language'
require 'rails-i18n'
require 'bcrypt'
require 'nav_lynx'



require "hello/engine"
require "hello/configuration"



  require "hello/errors"
  require "hello/locales"
  require 'hello/user_agent'


    require "hello/rails/model"
    require "hello/rails/controller"
    require "hello/rails/helper"



module Hello

  def self.available_time_zones
    ActiveSupport::TimeZone.send(:zones_map).values.map(&:name)
  end

  def self.encrypt_token(plain_text_string)
    Digest::MD5.hexdigest(plain_text_string)
  end

  def self.is_this_rails_4_0?
    ::Rails.version =~ /4.0/
  end

end
