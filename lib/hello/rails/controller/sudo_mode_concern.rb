module Hello
  module Rails
    module Controller
      module SudoModeConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
          def sudo_mode
            before_action(:sudo_mode)
          end
        end



        included do
          helper_method :sudo_mode?
        end



        def sudo_mode?
          current_access && current_access.sudo_expires_at.future?
        end

        def sudo_mode
          render_sudo_mode unless sudo_mode?
        end

            def render_sudo_mode
              session[:url] = url_for(params.merge only_path: true)
              render '/hello/sudo_mode/form'
            end

      end
    end
  end
end