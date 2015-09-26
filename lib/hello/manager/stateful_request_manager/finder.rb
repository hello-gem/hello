module Hello
  module Manager
    class StatefulRequestManager < RequestManager
      class Finder

        def initialize(manager)
          @manager = manager
        end

        def current_accesses
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
          @wanted_strings = @manager.session_tokens
        end

        def gather_wanted_models
          strings = @wanted_strings

          # a small attempt to avoid a database call unless needed
          case strings.size
          when 0 then return @models = []
          when 1 then strings = strings.first
          end

          # TODO:
          # optimize this process since each string starts with the user_id,
          # check StatelessRequestManager for example

          @models = Access.where(token: strings)
        end

        def gather_valid_strings
          @valid_strings = @models.map(&:active_token_or_destroy).map(&:presence).compact
        end

        def ensure_consistency_accross_models_and_session
          if @wanted_strings != @valid_strings
            @manager.session_tokens = @valid_strings
            @models = @models.select { |a| @valid_strings.include?(a.token) }
          end
        end

      end
    end    
  end
end
