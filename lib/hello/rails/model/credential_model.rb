module Hello
  module CredentialModel
    extend ActiveSupport::Concern

    included do
      belongs_to :user, counter_cache: true
      validates_presence_of :user

      validates_presence_of :type
      validates_inclusion_of :type, in: %w(EmailCredential PasswordCredential)
    end


    module ClassMethods
    end


    # def is_email?
    #   is_a?(EmailCredential)
    # end

    def first_error_message
      errors.messages.values.flatten.first if errors.any?
    end

    private

    def hello_is_user_being_destroyed?
      !!Thread.current["Hello.destroying_user"]
    end

  end
end
