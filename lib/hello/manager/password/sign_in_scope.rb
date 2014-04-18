module Hello
  class Manager
    class SignIn
      class SignInScope

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


        def error(&block)
          if block_given?
            @blocks[:error] = block
          else
            @blocks[:error]
          end
        end



        private

        
      end
    end
  end
end
