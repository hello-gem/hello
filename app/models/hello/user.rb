module Hello
  class User < ActiveRecord::Base
    has_many :identities
    has_many :sessions

    validates_presence_of :name

    module ClassMethods
      def roles
        [guest, user, admin]
      end

      def guest
        'guest'
      end

      def user
        'user'
      end

      def admin
        'admin'
      end
    end

  end
end
