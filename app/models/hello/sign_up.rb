module Hello
  class SignUp
    include ActiveModel::Model

    def initialize(controller, attrs=nil)
      @controller = controller
      self.class.send :attr_accessor, *permitted_fields
      if attrs
        attrs.slice(*permitted_fields).each { |k, v| instance_variable_set(:"@#{k}", v) }
      end
    end

    def credential
      @credential ||= Credential.classic.new(email: email, username: username, password: password)
    end

    def save
      credential.build_user(user_attributes)
      merge_errors_to_self and return false if are_models_invalid?
      credential.save
    end

    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end

    def error_message
      I18n.t("hello.messages.classic.registration.sign_up.error", count: errors.count)
    end




    private

        # initialize helpers

            def permitted_fields
              # Hello.config(:sign_up).fields
              # BaseSignUpStrategy.sign_up_fields
              # DummySignUpStrategy.new(@controller, self).sign_up_fields
              SignUpControl.new(@controller, self).sign_up_fields
            end

        # save helpers

        # returns {name: "...", city: "..."}
        def user_attributes
          r = {}
          user_fields.each { |k| r[k] = instance_variable_get(:"@#{k}") }
          r['locale'] ||= @controller.session['locale']
          r['role'] = 'user'
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
