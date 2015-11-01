require_relative "credential/core"

module Hello
  module Credential
    extend ActiveSupport::Concern

    included do
      unless self < ActiveRecord::Base
        msg = "Temporarily only supporting Rails and ActiveRecord, come make us a Pull Request"
        puts msg.yellow
        raise NotImplementedError.new(msg)
      end

      include Core
    end

  end
end
