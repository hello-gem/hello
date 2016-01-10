require_relative 'access/core'

module Hello
  module Access
    extend ActiveSupport::Concern

    included do
      unless self < ActiveRecord::Base
        msg = 'Temporarily only supporting Rails and ActiveRecord, come make us a Pull Request'
        puts msg.yellow
        fail NotImplementedError.new(msg)
      end

      include Core
    end

    module ClassMethods
    end
  end
end
