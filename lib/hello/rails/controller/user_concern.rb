module Hello
  module Rails
    module Controller
      module UserConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        #
        # User
        #

        included do
          helper_method :current_user, :is_current_user?
        end

        def current_user
          @current_user ||= current_access_token && current_access_token.user
        end

        def is_current_user?(user)
          current_user == user
        end

      end
    end
  end
end