module Hello
  class Manager
    class SignOut

      def config(&block)
        @scope = SignOutScope.new
        @scope.instance_eval(&block)
      end

      def success
        get_scope.success || raise("no success block")
      end





      private

          def get_scope
            reload && @scope
          end

          def reload
            config_file = ::Rails.root.join "app/hello/sign_out.rb"
            unless File.exists? config_file
              #`rails g hello:install`
              raise "should have config sign_out file"
            end

            load(config_file)
            self
          end


      class SignOutScope

        def initialize
          @blocks = {}
        end

        def success(&block)
          if block_given?
            @blocks[:success] = block
          else
            @blocks[:success]
          end
        end

        private

        
      end



    end
  end
end
