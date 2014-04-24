module Hello
  class Manager
    class Forgot

      def config(&block)
        @scope = ForgotScope.new
        @scope.instance_eval(&block)
      end

      def success
        get_scope.success || raise("no success block")
      end

      def error
        get_scope.error || raise("no error block")
      end

      def deliver_password_forgot
        get_scope.deliver_password_forgot || raise("no deliver_password_forgot block")
      end






      private

          def get_scope
            reload && @scope
          end

          def reload
            config_file = ::Rails.root.join "app/lib/hello/forgot.rb"
            unless File.exists? config_file
              #`rails g hello:install`
              raise "should have config forgot file"
            end

            load(config_file)
            self
          end





    end
  end
end
