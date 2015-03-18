module Hello
  module CredentialModel
    extend ActiveSupport::Concern

    included do
      belongs_to :user, counter_cache: true
      validates_presence_of :user

      scope :classic, -> { where(strategy: _classic) }

      validates_presence_of :strategy
      validates_inclusion_of :strategy, in: strategies


      # email
      validates_presence_of     :email, if: :is_classic?
      validates_email_format_of :email, if: :is_classic?
      validates_uniqueness_of   :email, if: :is_classic?

      # concerns
      # include CredentialModelEmail
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



    #
    # downcase setters
    #

    def email=(v)
      v = v.to_s.downcase.gsub(' ', '')
      write_attribute(:email, v)
    end

    #
    # email confirmation
    #

    def confirmation_status
      case
      # when !is_classic?
      #   :not_classic
      when email_confirmed?
        :confirmed
      when email_token_old?
        :must_deliver
      else
        :check_inbox
      end
    end

        def email_confirmed?
          !!email_confirmed_at
        end

        def email_token_old?
          x = email_token_digested_at
          x.nil? || x < 7.days.ago
        end



    def reset_password_token
      uuid = SecureRandom.hex(8) # probability = 1 / (16 ** 16)
      digest = self.class.encrypt_token(uuid)
      update(password_token_digest: digest, password_token_digested_at: 1.second.ago)
      return uuid
    end

    def invalidate_password_token
      update(password_token_digest: nil, password_token_digested_at: nil)
    end

    def reset_email_token!
      uuid = SecureRandom.hex(8) # probability = 1 / (16 ** 16)
      digest = Hello.encrypt_token(uuid)
      update!(email_token_digest: digest, email_token_digested_at: 1.second.ago)
      return uuid
    end

    def confirm_email!
      update! email_token_digest: nil, email_token_digested_at: nil, email_confirmed_at: 1.second.ago
    end




  end
end