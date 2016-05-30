module Hello
  module Business
    module Management
      class UpdateProfile < Base
        def initialize(user)
          @user = user
          self.class.send :attr_accessor, *permitted_column_names
        end

        def update(attrs)
          # puts "update(#{attrs})".blue
          clear_attrs(attrs).each do |k, v|
            # puts "@user.send('#{k}=', '#{v}')".blue
            @user.send("#{k}=", v)
          end
          @user.save
        end

        # def update(attrs)
        #   @user.update(clear_attrs(attrs))
        # end

        def errors
          @user.errors
        end

        private

        def clear_attrs(attrs)
          attrs.slice(*permitted_column_names)
        end

        def permitted_column_names
          ignore_columns = %w(id created_at updated_at role)
          the_columns = ::User.column_names
          the_columns -= ignore_columns
          the_columns.reject! { |column| column.ends_with? '_count' }
          the_columns.reject! { |column| column.starts_with? 'password_' }
          the_columns
        end
      end
    end
  end
end
