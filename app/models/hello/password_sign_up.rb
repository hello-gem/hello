module Hello
  class PasswordSignUp
    include ActiveModel::Model

    attr_accessor :name, :email, :username, :password
    attr_reader :identity

    def initialize(params=nil)
      if params
        write_attributes_to_self(params)
        initialize_identity
      end
    end

    def save
      identity.build_user(name: name)
      merge_errors_to_self and return false if are_models_invalid?
      identity.save
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end




    private

        # initialize helpers

        def write_attributes_to_self(attrs)
          attrs = attrs.slice(:name, :email, :username, :password)
          attrs.each { |k, v| instance_variable_set(:"@#{k}", v) }
        end

        def initialize_identity
          hash = {email: email, username: username, password: password, strategy: 'password'}
          # @identity = Identity.where(hash).first_or_initialize
          @identity = Identity.new(hash)
        end

        # save helpers

        def are_models_invalid?
          identity.invalid? || identity.user.invalid?
        end

        def merge_errors_to_self
          hash = identity.errors.to_hash.merge(identity.user.errors)
          hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
        end



  end
end
