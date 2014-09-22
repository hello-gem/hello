module Hello
  module Rails
    module Controller
      module TimeZoneConcern
        
        extend ActiveSupport::Concern

        # module ClassMethods
        # end

        included do
          around_filter :user_time_zone, if: :hello_user
        end

        private

          def user_time_zone(&block)
            Time.use_zone(hello_user.time_zone, &block)
          end

      end
    end
  end
end
