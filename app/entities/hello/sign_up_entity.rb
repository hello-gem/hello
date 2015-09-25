module Hello
  class SignUpEntity < AbstractEntity

    # Used for configuration only
    class Mod
    end

    attr_reader :credential

    def initialize
      @config = get_config
      generate_accessors
      write_defaults
    end

    def save(attrs)
      write_attrs(attrs)
      create_credential
    end

    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def email_taken?
      credential && credential.errors.added?(:email, :taken)
    end

    # errors.added? DOES NOT WORK when the validation was given a custom message :)
    def username_taken?
      credential && user.errors.added?(:username, :taken)
    end

    def user
      credential.user
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
              @config[:user_fields] + %w(email)
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
            def create_credential
              @credential = build_models
              if invalidate_models
                merge_model_errors
                return false
              end
              @credential.save!
            end

                def build_models
                  EmailCredential.new(email: email) do |c|
                    c.build_user(user_attributes)
                  end
                end

                def invalidate_models
                  # credential.invalid? || user.invalid?
                  a=credential.invalid?
                  b=user.invalid?
                  a || b
                end

                def merge_model_errors
                  hash = credential.errors.to_hash.merge(user.errors)
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
