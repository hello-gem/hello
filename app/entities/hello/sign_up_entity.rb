module Hello
  class SignUpEntity < AbstractEntity

    attr_accessor :credential

    def initialize(controller)
      @controller = controller
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
      credential.errors.added? :username, :taken
    end


    private

        # initialize helpers

        def generate_accessors
          self.class.send :attr_accessor, *all_fields
        end

            def all_fields
              credential_fields + user_fields
            end

                def credential_fields
                  %w(email username password)
                end

                def user_fields
                  control.user_fields.map(&:to_s)
                end

        def write_defaults
          # defaults.each { |k, v| instance_variable_set(:"@#{k}", v) }
          defaults.each { |k, v| send("#{k}=", v) }
        end

            def defaults
              control.defaults.stringify_keys
            end

                def control
                  @control ||= SignUpControl.new(@controller, self)
                end

        # save helpers

        def write_attrs(attrs)
          # attrs.slice(*all_fields).each { |k, v| instance_variable_set(:"@#{k}", v) if v }
          attrs.slice(*all_fields).each { |k, v| send("#{k}=", v) if v }
        end

            # NOTE: 
            # All validations are delegated to the models
            def build_credential
              self.credential = Credential.classic.new(email: email, username: username, password: password)
              credential.build_user(user_attributes)
              merge_errors_to_self and return false if are_models_invalid?
            end

                def are_models_invalid?
                  # credential.invalid? || credential.user.invalid?
                  a=credential.invalid?
                  b=credential.user.invalid?
                  a || b
                end

                def merge_errors_to_self
                  hash = credential.errors.to_hash.merge(credential.user.errors)
                  hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
                end


        # returns {name: "...", city: "..."}
        def user_attributes
          r = {}
          user_fields.each { |k| r[k.to_s] = instance_variable_get(:"@#{k}") }
          r['role'] = 'novice'
          r
        end




  end
end
