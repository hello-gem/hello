require "hello/engine"

require "hello/config"

require "hello/rails/controller"
require "hello/rails/helper"

require 'colorize'
require 'before_actions'
require 'validates_email_format_of'

module Hello

  def self.config
    Config.instance
  end

end
