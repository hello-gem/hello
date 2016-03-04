module Hello
  class ClassicSignUpEntity < AbstractEntity
    attr_reader :email_credential, :password_credential, :user

    def initialize
      generate_accessors
      write_defaults
    end

    def register(attrs)
      write_attrs(attrs.with_indifferent_access)
      create_models
    end

    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def email_taken?
      @email_credential && @email_credential.errors.added?(:email, :taken)
    end

    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def username_taken?
      @user && user.errors.added?(:username, :taken)
    end

    private

    # initialize helpers

    def generate_accessors
      self.class.send :attr_accessor, *all_fields
    end

    def all_fields
      user_fields + %w(email password)
    end

    def write_defaults
      # defaults.each { |k, v| instance_variable_set(:"@#{k}", v) }
      defaults.each { |k, v| send("#{k}=", v) }
    end

    # save helpers

    def write_attrs(attrs)
      # attrs.slice(*all_fields).each { |k, v| instance_variable_set(:"@#{k}", v) if v }
      attrs.slice(*all_fields).each { |k, v| send("#{k}=", v) if v }
    end

    # NOTE:
    # All validations are delegated to the models
    def create_models
      validate_presences
      return false if errors.any?

      build_and_validate_models
      return false if errors.any?

      save_models!
      true
    end

    def validate_presences
      validates_presence_of :email if validates_presence_of_email?

      validates_presence_of :username if validates_presence_of_username?

      validates_presence_of :password if validates_presence_of_password?

      ::User.validators.each do |validator|
        next unless validator.is_a?(ActiveRecord::Validations::PresenceValidator)
        next unless validator.attributes.first.to_sym != :username
        options = validator.options.dup
        options[:attributes] = validator.attributes
        validates_with(validator.class, options)
      end
    end

    def build_and_validate_models
      # user & username
      @user = ::User.new(user_attributes)
      if username.blank? && !validates_presence_of_username?
        user.set_generated_username
      end
      merge_errors_for(user)

      # email_credential & email
      if email.present? || validates_presence_of_email?
        @email_credential = ::EmailCredential.new user: @user, email: email
        merge_errors_for(email_credential)
      end

      # password_credential & password
      @password_credential = ::PasswordCredential.new user: @user, password: password
      if password.blank? && !validates_presence_of_password?
        password_credential.set_generated_password
      end
      merge_errors_for(password_credential)
    end

    def merge_errors_for(model)
      model.valid?
      model.errors.each do |k, v|
        errors.add(k, v)
      end
    end

    def save_models!
      user.save!
      email_credential && email_credential.save!
      password_credential.save!
    end

    # returns {name: "...", city: "..."}
    def user_attributes
      r = {}
      user_fields.each { |k| r[k.to_s] = instance_variable_get(:"@#{k}") }
      r['role'] = starting_role
      r
    end

    def starting_role
      'onboarding'
    end

    def user_fields
      Hello.configuration.classic_sign_up_fields.map(&:to_s)
    end

    def defaults
      {
        locale:    I18n.locale.to_s,
        time_zone: Time.zone.name
      }
    end

    # config helpers

    def validates_presence_of_email?
      Hello.configuration.email_presence
    end

    def validates_presence_of_username?
      Hello.configuration.username_presence
    end

    def validates_presence_of_password?
      Hello.configuration.password_presence
    end

    # just because!

    def self._reflect_on_association(*_args)
    end
  end
end
