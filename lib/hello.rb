require "hello/engine"

require "hello/config"

require "hello/errors"

require "hello/rails/controller"
require "hello/rails/helper"

require 'colorize'
require 'before_actions'
require 'validates_email_format_of'
require 'user_agent_parser'

module Hello

  def self.config(name, &block)
    Config.instance.config_for(name, &block)
  end



  # 
  # https://github.com/toolmantim/user_agent_parser
  #

  # Instantiate the parser on load as it's quite expensive
  USER_AGENT_PARSER = UserAgentParser::Parser.new

  def self.user_agent_parser
    USER_AGENT_PARSER
  end

end
