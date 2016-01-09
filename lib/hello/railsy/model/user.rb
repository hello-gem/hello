require_relative "user/core"
require_relative "user/username"

module Hello
  module User
    extend ActiveSupport::Concern

    included do
      unless self < ActiveRecord::Base
        msg = "Temporarily only supporting Rails and ActiveRecord, come make us a Pull Request"
        puts msg.yellow
        raise NotImplementedError.new(msg)
      end

      include Core
      include Username
    end



    module ClassMethods

      def hello_apply_config!
        Hello.configuration.tap do |c|
          validates_format_of :username, with: c.username_regex
          validates_length_of :username, in:   c.username_length
        end
      end
    end

  end
end
