module Hello
  module UserModelRoles
    extend ActiveSupport::Concern



    # included do
    # end

    module ClassMethods

      def mock_guest
        new(role: 'guest')
      end

      def roles
        # [guest, novice, user, webmaster]
        [novice_role, user_role, webmaster_role]
      end

      # def guest
      #   'guest'
      # end

      def novice_role
        'novice'
      end

      def user_role
        'user'
      end

      def webmaster_role
        'webmaster'
      end

    end



    def guest?
      role == 'guest'
    end

    def novice?
      role == self.class.novice_role
    end

    def user?
      webmaster? ||
      role == self.class.user_role
    end

    def webmaster?
      role == self.class.webmaster_role
    end

    def role_is?(role)
      self.send("#{role}?")
    end



    # def turn_novice_to_user!
    #   # place additional code here
    #   update! role: User.user_role
    # end




  end
end