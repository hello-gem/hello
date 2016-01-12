module Hello
  class SignUpEntity < AbstractEntity
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
              validates_presence_of :email
              validates_presence_of :username

              if validates_presence_of_password?
                validates_presence_of :password
              end

              ::User.validators.each do |validator|
                if validator.is_a?(ActiveRecord::Validations::PresenceValidator)
                  options = validator.options.dup
                  options[:attributes] = validator.attributes
                  validates_with(validator.class, options)
                end
              end
            end

            def build_and_validate_models
              @user = ::User.new(user_attributes)
              @email_credential    = ::EmailCredential.new    user: @user, email:    email
              @password_credential = ::PasswordCredential.new user: @user, password: password

              if not validates_presence_of_password?
                if password.blank?
                  password_credential.set_generated_password
                end
              end

              merge_errors_for(user)
              merge_errors_for(email_credential)
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
              email_credential.save!
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
      Hello.configuration.email_sign_up_role
    end

    def user_fields
      Hello.configuration.email_sign_up_fields.map(&:to_s)
    end

    def defaults
      {
        locale:    I18n.locale.to_s,
        time_zone: Time.zone.name
      }
    end

    # config helpers

    def validates_presence_of_password?
      Hello.configuration.password_presence
    end

    # just because!

    def self._reflect_on_association(*args)
    end

  end
end
