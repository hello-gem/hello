module Hello
  module CredentialModel
    extend ActiveSupport::Concern

    included do
      belongs_to :user, counter_cache: true
      validates_presence_of :user

      scope :classic, -> { where(strategy: _classic) }

      validates_presence_of :strategy
      validates_inclusion_of :strategy, in: strategies

      before_destroy :cannot_destroy_last_credential

      # concerns
      include CredentialModelEmail
      # include Twitter
    end


    module ClassMethods
      def strategies
        [_classic, _twitter]
      end

      def _classic
        'classic'
      end

      def _twitter
        'twitter'
      end
    end


    def is_classic?
      strategy.to_s.inquiry.classic?
    end

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