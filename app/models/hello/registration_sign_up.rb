module Hello
  class RegistrationSignUp
    include ActiveModel::Model

    
    attr_reader :credential

    def initialize(sign_up_params=nil)
      self.class.send :attr_accessor, *permitted_fields
      if sign_up_params
        write_attributes_to_self(sign_up_params)
        initialize_credential
      end
    end

    def save
      credential.build_user(user_attributes)
      merge_errors_to_self and return false if are_models_invalid?
      credential.save
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end




    private

        # initialize helpers

        def write_attributes_to_self(attrs)
          attrs = attrs.slice(*permitted_fields)
          attrs.each { |k, v| instance_variable_set(:"@#{k}", v) }
        end

            def permitted_fields
              Hello.config.sign_up.fields
            end

        def initialize_credential
          hash = {email: email, username: username, password: password}
          @credential = Credential.classic.new(hash)
        end

        # save helpers

        # {name: "...", city: "..."}
        def user_attributes
          r = {}
          user_fields.each { |k| r[k] = instance_variable_get(:"@#{k}") }
          r
        end

            # [:name, :city]
            def user_fields
              non_user_fields = [:username, :email, :password, :password_confirmation]
              permitted_fields - non_user_fields
            end

        def are_models_invalid?
          credential.invalid? || credential.user.invalid?
          # a=credential.invalid?
          # b=credential.user.invalid?
          # a || b
        end

        def merge_errors_to_self
          hash = credential.errors.to_hash.merge(credential.user.errors)
          hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
        end



  end
end
