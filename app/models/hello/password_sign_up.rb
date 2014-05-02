module Hello
  class PasswordSignUp
    include ActiveModel::Model

    
    attr_reader :identity

    def initialize(params=nil)
      self.class.send :attr_accessor, *permitted_fields
      if params
        write_attributes_to_self(params)
        initialize_identity
      end
    end

    def save
      identity.build_user(user_attributes)
      merge_errors_to_self and return false if are_models_invalid?
      identity.save
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

        def initialize_identity
          hash = {email: email, username: username, password: password, strategy: 'password'}
          # @identity = Identity.where(hash).first_or_initialize
          @identity = Identity.new(hash)
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
          identity.invalid? || identity.user.invalid?
          # a=identity.invalid?
          # b=identity.user.invalid?
          # a || b
        end

        def merge_errors_to_self
          hash = identity.errors.to_hash.merge(identity.user.errors)
          hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
        end



  end
end
