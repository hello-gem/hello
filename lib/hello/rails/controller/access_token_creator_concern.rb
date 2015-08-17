module Hello
  module Rails
    module Controller
      module AccessTokenCreatorConcern
        
        # extend ActiveSupport::Concern

        # module ClassMethods
        # end

        # included do
        # end

        def create_access_token_for(user, expires_at=nil, sudo_expires_at=nil)
          model = _create_access_token_model(user, expires_at, sudo_expires_at)
          _create_access_token_session(model.access_token)
          return model
        end

            def _create_access_token_model(user, expires_at, sudo_expires_at)
              expires_at ||= hello_default_session_expiration
              remote_ip  =   request.remote_ip

              attrs = {
                user:               user,
                user_agent_string:  user_agent,
                expires_at:         expires_at,
                ip:                 remote_ip
              }
              attrs[:sudo_expires_at] = sudo_expires_at if sudo_expires_at
              AccessToken.create!(attrs)
            end

            def _create_access_token_session(string)
              self.session_access_token = string
              self.session_access_tokens << string
              set_session_locale(nil)
            end




      end
    end
  end
end