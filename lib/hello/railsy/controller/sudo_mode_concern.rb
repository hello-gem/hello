module Hello
  module Railsy
    module Controller
      module SudoModeConcern
        extend ActiveSupport::Concern

        module ClassMethods
          def sudo_mode(options = {})
            before_action(options) { sudo_mode }
          end
        end

        included do
          helper_method :sudo_mode?
        end

        def hello_keep_current_url_on_session!
          session[:url] = url_for(params.permit!.merge(only_path: true))
        end

        def sudo_mode?
          current_access && current_access.sudo_expires_at.future?
        end

        def sudo_mode
          render_sudo_mode unless sudo_mode?
        end

        def render_sudo_mode
          hello_keep_current_url_on_session!
          render_sudo_mode_form
        end

        def render_sudo_mode_form
          render 'hello/authentication/sudo_mode/form'
        end
      end
    end
  end
end
