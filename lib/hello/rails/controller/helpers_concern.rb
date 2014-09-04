module Hello
  module Rails
    module Controller
      module HelpersConcern
        
        extend ActiveSupport::Concern

        module ClassMethods
        end

        included do
          helper_method :hello_send_confirmation_email_entity,
                        :hello_confirm_email_entity
        end


        def hello_send_confirmation_email_entity
          Hello::SendConfirmationEmailEntity.new(self, hello_credential)
        end

        def hello_confirm_email_entity
          Hello::ConfirmEmailEntity.new(hello_credential)
        end

      end
    end
  end
end