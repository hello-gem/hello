module Hello
  class Manager
    class SignIn

      def config(&block)
        @scope = SignInScope.new
        @scope.instance_eval(&block)
      end

      def success
        get_scope.success || raise("no success block")
      end

      def error
        get_scope.error || raise("no error block")
      end






      private

          def get_scope
            reload && @scope
          end

          def reload
            config_file = ::Rails.root.join "app/hello/sign_in.rb"
            unless File.exists? config_file
              #`rails g hello:install`
              raise "should have config sign_in file"
            end

            load(config_file)
            self
          end





    end
  end
end
