require_relative 'user/core'
require_relative 'user/username'

module Hello
  module User
    extend ActiveSupport::Concern

    included do
      unless self < ActiveRecord::Base
        msg = 'Temporarily only supporting Rails and ActiveRecord, come make us a Pull Request'
        puts msg.yellow
        fail NotImplementedError.new(msg)
      end

      include Core
      include Username
    end
  end
end
