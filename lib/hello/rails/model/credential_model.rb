module Hello
  module CredentialModel
    extend ActiveSupport::Concern

    included do
      belongs_to :user, counter_cache: true
      validates_presence_of :user

      scope :classic, -> { where(strategy: _classic) }

      validates_presence_of :strategy
      validates_inclusion_of :strategy, in: strategies


      before_validation :ensure_username_if_blank_allowed_on_create, on: :create


      # username
      validates_format_of :username, with: /\A[a-z0-9_-]+\z/i
      validates_uniqueness_of :username
      validates_length_of :username,
                          in: 4..32,
                          too_long:  'maximum of %{count} characters',
                          too_short: 'minimum of %{count} characters'

      # concerns
      include CredentialModelPassword
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

    # we recommend programmers to override this method in their apps
    def encrypt_password(plain_text_password)
      BCrypt::Password.create(plain_text_password)
    end

    # we recommend programmers to override this method in their apps
    def password_is?(plain_text_password)
      bc_password = BCrypt::Password.new(password_digest)
      bc_password == plain_text_password 
    rescue BCrypt::Errors::InvalidHash
      false
    end


    #
    # email confirmation
    #

    def show_alert_for_email_confirmation_suggestion?
      is_classic? && !email_confirmed? && email_token_expired?
    end

    def show_alert_for_email_confirmation_pending?
      is_classic? && !email_confirmed? && !email_token_expired?
    end

        def email_confirmed?
          !!email_confirmed_at
        end

        def email_token_expired?
          email_token_digested_at < 7.days.ago
        end



    def ensure_username_if_blank_allowed_on_create
      return true if username.present?              # skip if username has been set
      return true if username_presence_is_required? # skip if username presence is required
      string = make_up_new_username
      string = make_up_new_username until not username_used_by_another?(string)
      self.username = string
    end

        def make_up_new_username
          SecureRandom.hex(16) # probability = 1 / (32 ** 32)
        end

        def username_used_by_another?(a_username)
          self.class.where(username: a_username).where.not(id: id).exists?
        end

        def username_presence_is_required?
          _validators[:username].map(&:class).include? ActiveRecord::Validations::PresenceValidator
        end






    # def username_suggestions
    #   email1 = email.to_s.split('@').first
    #   name1  = name.to_s.split(' ')
    #   ideas = [name1, email1].flatten
    #   [ideas.sample, rand(999)].join.parameterize
    # end


  end
end