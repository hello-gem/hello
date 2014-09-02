module Hello
  class Deactivate
    include ActiveModel::Model

    # def initialize(controller=nil)
      # self.class.send :attr_accessor, *permitted_fields
      # if controller
      #   @controller = controller
      #   write_attributes_to_self
      # end
    # end

    # yes, pretty empty
    def errors
      @errors ||= ActiveModel::Errors.new(self)
    end

    # def error_message
    #   I18n.t("hello.messages.classic.registration.sign_up.error", count: errors.count)
    # end




    private

        # initialize helpers

        # def write_attributes_to_self
        #   attrs = @controller.params.require(:sign_up)
        #   attrs = attrs.slice(*permitted_fields)
        #   attrs.each { |k, v| instance_variable_set(:"@#{k}", v) }
        # end

        #     def permitted_fields
        #       Hello.config(:sign_up).fields
        #     end

        # # save helpers

        # # returns {name: "...", city: "..."}
        # def user_attributes
        #   r = {}
        #   user_fields.each { |k| r[k] = instance_variable_get(:"@#{k}") }
        #   r['locale'] ||= @controller.session['locale']
        #   r['role'] = 'user'
        #   r
        # end

        #     # [:name, :city]
        #     def user_fields
        #       non_user_fields = [:username, :email, :password, :password_confirmation]
        #       permitted_fields - non_user_fields
        #     end

        # def are_models_invalid?
        #   credential.invalid? || credential.user.invalid?
        #   # a=credential.invalid?
        #   # b=credential.user.invalid?
        #   # a || b
        # end

        # def merge_errors_to_self
        #   hash = credential.errors.to_hash.merge(credential.user.errors)
        #   hash.each { |k,v| v.each { |v1| errors.add(k, v1) } }
        # end



  end
end
