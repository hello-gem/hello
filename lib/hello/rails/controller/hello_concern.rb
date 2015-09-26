module Hello
  module Rails
    module Controller
      module HelloConcern
        extend ActiveSupport::Concern

        included do
          helper_method :current_user,
                        :current_accesses,
                        :current_access,
                        :signed_in?,
                        :is_current_access?

          delegate  :sign_in!,
                    :sign_out!,
                    :signed_in?,
                    
                    :current_user,
                    :is_current_user?,
                    
                    :current_access,
                    :current_accesses,
                    :is_current_access?,

                    :session_token=,
                    :session_tokens,

                    to: :hello_manager
          
        end

        def hello_manager
          env['hello'] ||= Hello::Manager::RequestManager.create(request)
        end

      end
    end
  end
end