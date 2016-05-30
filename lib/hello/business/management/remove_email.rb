module Hello
  module Business
    module Management
      class RemoveEmail < Base
        def initialize(email_credential)
          @email_credential = email_credential
        end

        def success_message
          super(email: @email_credential.email)
        end

        def error_message
          @email_credential.errors.full_messages.first
        end
      end
    end
  end
end
