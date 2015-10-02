module Hello
  class SignUpEntity < AbstractEntity

    # Used for configuration only
    class Mod
    end

    attr_reader :email_credential, :password_credential, :user

    def initialize
      @config = get_config
      generate_accessors
      write_defaults
    end

    def save(attrs)
      write_attrs(attrs)
      create_models
    end

    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def email_taken?
      @email_credential and @email_credential.errors.added?(:email, :taken)
    end

    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def username_taken?
      @user and user.errors.added?(:username, :taken)
    end

    private

        # initialize helpers

        def get_config
          x = Mod.new
          {
            user_fields:   x.fields.map(&:to_s),
            defaults:      x.defaults.stringify_keys,
            starting_role: x.starting_role,
          }
        end

        def generate_accessors
          self.class.send :attr_accessor, *all_fields
        end

            def all_fields
              @config[:user_fields] + %w(email password)
            end

        def write_defaults
          # defaults.each { |k, v| instance_variable_set(:"@#{k}", v) }
          @config[:defaults].each { |k, v| send("#{k}=", v) }
        end

        # save helpers

        def write_attrs(attrs)
          # attrs.slice(*all_fields).each { |k, v| instance_variable_set(:"@#{k}", v) if v }
          attrs.slice(*all_fields).each { |k, v| send("#{k}=", v) if v }
        end

            # NOTE:
            # All validations are delegated to the models
            def create_models
              build_models
              if invalidate_models
                merge_model_errors
                return false
              end
              @user.save!
              @email_credential.save!
              @password_credential.save!
            end

                def build_models
                  @user                = User.new(user_attributes)
                  @email_credential    = EmailCredential.new    user: @user, email:    email
                  @password_credential = PasswordCredential.new user: @user, password: password
                end

                def invalidate_models
                  # run all model validations without skipping
                  a = email_credential.invalid?
                  b = password_credential.invalid?
                  c = user.invalid?
                  a || b || c
                end

                def merge_model_errors
                  hash = email_credential.errors.to_hash.merge(user.errors).merge(password_credential.errors)
                  hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
                end

        # returns {name: "...", city: "..."}
        def user_attributes
          r = {}
          @config[:user_fields].each { |k| r[k.to_s] = instance_variable_get(:"@#{k}") }
          r['role'] = @config[:starting_role]
          r
        end

  end
end
