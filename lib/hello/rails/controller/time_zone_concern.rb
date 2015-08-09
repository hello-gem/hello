module Hello
  module Rails
    module Controller
      module TimeZoneConcern
        
        extend ActiveSupport::Concern

        # module ClassMethods
        # end

        included do
          around_filter :user_time_zone, if: :current_user
        end

        private

          def user_time_zone(&block)
            Thread.current["Hello.destroying_user"] = nil
            Time.use_zone(current_user.time_zone, &block)
            Thread.current["Hello.destroying_user"] = nil
          end

      end
    end
  end
end
