module Hello
  module Rails
    module Controller
      module HelloConcern
        extend ActiveSupport::Concern

        included do
          helper_method :current_user,
                        :current_access_tokens,
                        :current_access_token,
                        :signed_in?,
                        :is_current_access_token?

          delegate  :sign_in!,
                    :sign_out!,
                    :signed_in?,
                    
                    :current_user,
                    :is_current_user?,
                    
                    :current_access_token,
                    :current_access_tokens,
                    :is_current_access_token?,

                    :session_access_token=,
                    :session_access_tokens,

                    to: :hello_manager
          
        end

        def hello_manager
          env['hello'] ||= Hello::Manager::RequestManager.create(request)
        end

      end
    end
  end
end