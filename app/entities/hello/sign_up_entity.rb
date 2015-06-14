module Hello
  class SignUpEntity < AbstractEntity

    attr_accessor :credential

    def initialize(controller)
      @controller  = controller
      set_internal_vars
      generate_accessors
      write_defaults
    end

    def save(attrs)
      write_attrs(attrs)
      build_credential
      credential.save
    end


    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def email_taken?
      return false unless credential
      credential.errors.added? :email, :taken
    end

    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def username_taken?
      return false unless credential
      user.errors.added? :username, :taken
    end

    def user
      credential.user
    end


    private

        # initialize helpers

        def set_internal_vars
          x = User.new
          @user_fields = x.sign_up_attribute_names.map(&:to_s)
          @defaults    = x.sign_up_default_attributes.stringify_keys
        end

        def generate_accessors
          self.class.send :attr_accessor, *all_fields
        end

            def all_fields
              credential_fields + @user_fields
            end

                def credential_fields
                  %w(email)
                end

        def write_defaults
          # defaults.each { |k, v| instance_variable_set(:"@#{k}", v) }
          @defaults.each { |k, v| send("#{k}=", v) }
        end

        # save helpers

        def write_attrs(attrs)
          # attrs.slice(*all_fields).each { |k, v| instance_variable_set(:"@#{k}", v) if v }
          attrs.slice(*all_fields).each { |k, v| send("#{k}=", v) if v }
        end

            # NOTE: 
            # All validations are delegated to the models
            def build_credential
              self.credential = Credential.classic.new(email: email)
              credential.build_user(user_attributes)
              merge_errors_to_self and return false if are_models_invalid?
            end

                def are_models_invalid?
                  # credential.invalid? || user.invalid?
                  a=credential.invalid?
                  b=user.invalid?
                  a || b
                end

                def merge_errors_to_self
                  hash = credential.errors.to_hash.merge(user.errors)
                  hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
                end


        # returns {name: "...", city: "..."}
        def user_attributes
          r = {}
          @user_fields.each { |k| r[k.to_s] = instance_variable_get(:"@#{k}") }
          r['role'] = 'novice'
          r
        end




  end
end
