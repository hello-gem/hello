module Hello
  module RailsActiveRecord
    class User < ::ActiveRecord::Base
      self.table_name = 'users'

      # ASSOCIATIONS

      has_many :credentials,          dependent: :destroy, class_name: '::Credential'
      has_many :email_credentials,    dependent: :destroy, class_name: '::EmailCredential'
      has_one  :password_credential,  dependent: :destroy, class_name: '::PasswordCredential'
      has_many :password_credentials, dependent: :destroy, class_name: '::PasswordCredential'
      has_many :accesses,             dependent: :destroy, class_name: '::Access'

      alias :main_password_credential :password_credential

      # VALIDATIONS

      validates_presence_of :username, :locale, :time_zone
      validates_uniqueness_of :username
      validate :hello_validations

      # SETTERS

      def username=(v)
        super(v.to_s.downcase.remove(' '))
      end

      # OVERRIDES

      def destroy
        # In Rails 4.0
        # 'this instance' and the 'user in the credential instance'
        # are 2 separate instances, making it impossible for them to share state
        # therefore, an instance variable used as a flag will not work for Rails 4.0
        # It will however, work for Rails 4.1 and 4.2
        # @hello_is_this_being_destroyed = true
        Thread.current['Hello.destroying_user'] = true
        super
      end

      # def hello_is_this_being_destroyed?
      #   !!@hello_is_this_being_destroyed
      # end


      # CUSTOM METHODS

      def as_json_web_api
        as_json
      end

      def password_is?(plain_text_password)
        password_credential.password_is?(plain_text_password)
      end

      def role_is?(role)
        send("#{role}?")
      end

      def in_any_role?(roles)
        roles.each { |r| role_is?(r) and return true }
        false
      end

      def set_generated_username
        loop do
          self.username = _make_up_new_username
          break if _username_unique?
        end
      end

      private

      def hello_validations
        c = Hello.configuration

        validates_inclusion_of :locale,    in:   c.locales
        validates_inclusion_of :time_zone, in:   c.time_zones
        validates_format_of    :username,  with: c.username_regex
        validates_length_of    :username,  in:   c.username_length
      end

      def _make_up_new_username
        Hello::Encryptors::Simple.instance.single(16) # 16 chars
      end

      def _username_unique?
        !self.class.unscoped.where(username: username).where.not(id: id).exists?
      end

      # def username_suggestions
      #   email1 = email.to_s.split('@').first
      #   name1  = name.to_s.split(' ')
      #   ideas = [name1, email1].flatten
      #   [ideas.sample, rand(999)].join.parameterize
      # end
    end
  end
end
