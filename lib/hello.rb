require "hello/engine"

require "hello/manager/manager"

require "hello/rails/controller"
require "hello/rails/helper"

require 'colorize'
require 'before_actions'
require 'validates_email_format_of'

module Hello

  def self.sign_up
    Manager.instance.sign_up
  end

  def self.sign_in
    Manager.instance.sign_in
  end

  def self.forgot
    Manager.instance.forgot
  end

  # def self.twitter
  #   Manager.instance.twitter
  # end
end
