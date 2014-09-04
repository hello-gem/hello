module Hello
  class UpdateMyUserEntity < AbstractEntity

    def initialize(user, attrs=nil)
      @user = user
      self.class.send :attr_accessor, *permitted_fields
      if attrs
        attrs.slice(*permitted_fields).each { |k, v| instance_variable_set(:"@#{k}", v) }
      end
    end

    def update(attrs)
      clear_attrs(attrs).each do |k, v|
        @user.send("#{k}=", v)
      end
      @user.save
    end

    def errors
      @user.errors
    end



    private

        def clear_attrs(attrs)
          attrs.slice(*permitted_fields)
        end

        def permitted_fields
          User.hello_profile_column_names
        end

  end
end