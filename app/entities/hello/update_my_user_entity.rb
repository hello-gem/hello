module Hello
  class UpdateMyUserEntity < AbstractEntity

    def initialize(user)
      @user = user
      self.class.send :attr_accessor, *permitted_fields
    end

    def update(attrs)
      # puts "update(#{attrs})".blue
      clear_attrs(attrs).each do |k, v|
        # puts "@user.send('#{k}=', '#{v}')".blue
        @user.send("#{k}=", v)
      end
      @user.save
    end

    def errors
      @user.errors
    end



    private

        def clear_attrs(attrs)
          # puts "permitted_fields -> #{permitted_fields}".blue
          attrs.slice(*permitted_fields)
        end

        def permitted_fields
          User.hello_profile_column_names+['password']
        end

  end
end