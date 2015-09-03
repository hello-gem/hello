module Hello
  module Manager
    class StatefulRequestManager < RequestManager
      class Finder

        def initialize(manager)
          @manager = manager
        end

        def current_access_tokens
          @models || models
        end

        def models
          gather_wanted_strings
          gather_wanted_models

          gather_valid_strings
          ensure_consistency_accross_models_and_session
          
          return @models
        end

        private

        def gather_wanted_strings
          @wanted_strings = @manager.session_access_tokens
        end

        def gather_wanted_models
          strings = @wanted_strings

          # a small attempt to avoid a database call unless needed
          case strings.size
          when 0 then return @models = []
          when 1 then strings = strings.first
          end

          @models = AccessToken.where(access_token: strings)
        end

        def gather_valid_strings
          @valid_strings = @models.map(&:active_access_token_or_destroy).map(&:presence).compact
        end

        def ensure_consistency_accross_models_and_session
          if @wanted_strings != @valid_strings
            @manager.session_access_tokens = @valid_strings
            @models = @models.select { |at| @valid_strings.include?(at.access_token) }
          end
        end

      end
    end    
  end
end
