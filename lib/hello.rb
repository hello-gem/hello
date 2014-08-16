require "hello/engine"

require "hello/config"

require "hello/errors"

require "hello/locale_names"

require "hello/rails/controller"
require "hello/rails/helper"

require 'colorize'
require 'before_actions'
require 'validates_email_format_of'

require 'user_agent_parser'
require 'http_accept_language'

module Hello

  def self.config(name, &block)
    Config.instance.config_for(name, &block)
  end

  def self.available_locales
    # yes, it would be better if this was not hardcoded
    # but we need this list somewhere so we can point out when a language is not supported by this gem
    ['en', 'pt-BR']
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
