module Hello
  class Manager
    class Forgot
      class ForgotScope

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

        def deliver_password_forgot(&block)
          if block_given?
            @blocks[:deliver_password_forgot] = block
          else
            @blocks[:deliver_password_forgot]
          end
        end



        private

        
      end
    end
  end
end
