module Hello
  module CredentialModel
    extend ActiveSupport::Concern

    included do
      belongs_to :user, counter_cache: true
      validates_presence_of :user

      validates_presence_of :type
      validates_inclusion_of :type, in: %w(EmailCredential)

      before_destroy :cannot_destroy_last_credential
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

    def cannot_destroy_last_credential
      return if hello_is_user_being_destroyed?
      return if not is_last_credential?
      errors[:base] << "must have at least one credential"
      false
    end

    def is_last_credential?
      user.credentials_count == 1
    end

    def hello_is_user_being_destroyed?
      !!Thread.current["Hello.destroying_user"]
    end

  end
end