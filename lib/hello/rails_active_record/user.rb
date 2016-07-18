module Hello
  module RailsActiveRecord
    module User
      extend ActiveSupport::Concern

      included do
        # ASSOCIATIONS

        has_many :credentials,          dependent: :destroy
        has_many :email_credentials,    dependent: :destroy
        has_many :password_credentials, dependent: :destroy
        has_many :accesses,             dependent: :destroy

        # VALIDATIONS

        validates_presence_of :role, :locale, :time_zone
        validates_uniqueness_of :username, if: :username?
        validate :hello_validations

        # DELEGATIONS

        delegate :password_is?, to: :password_credential
      end

      # SETTERS

      def username=(v)
        super(v.to_s.downcase.remove(' '))
      end

      def email=(v)
        return if v.blank?
        if email_credentials.any?
          fail "use 'email_credentials.build(email: v)' instead"
        else
          email_credentials.build(user: self, email: v)
        end
      end

      def password=(v)
        return if v.blank?
        if password_credentials.any?
          fail "update your 'password_credential' instead"
        else
          password_credential.password=v
        end
      end

      # GETTERS

      def email
        email_credentials.first.email
      rescue
        nil
      end

      def password
        password_credential.password # yes, it might come blank
      rescue
        nil
      end

      def password_credential
        @password_credential ||= password_credentials.first_or_initialize(user: self)
      end

      # CUSTOM METHODS

      def as_json_web_api
        as_json
      end

      def in_any_role?(roles)
        roles.each { |r| role_is?(r) and return true }
        false
      end

      private

      def hello_validations
        c = Hello.configuration
        validates_inclusion_of :locale,    in:   c.locales
        validates_inclusion_of :time_zone, in:   c.time_zones

        hello_validations_username(c)
        hello_validations_email(c)
        hello_validations_password(c)
      end

      def hello_validations_username(c)
        if c.username_presence
          validates_presence_of :username
        end
        if username.present?
          validates_format_of :username,  with: c.username_regex
          validates_length_of :username,  in:   c.username_length
        end
      end

      def hello_validations_email(c)
        if c.email_presence
          validates_length_of :email_credentials, minimum: 1
          validates_presence_of :email
        end
      end

      def hello_validations_password(c)
        if new_record?
          if c.password_presence
            validates_presence_of :password
          elsif password.blank?
            password_credential.set_generated_password
          end
        end
        validates_length_of :password_credentials, is: 1
      end

    end
  end
end
