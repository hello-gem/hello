module Hello
  module UserModel
    extend ActiveSupport::Concern


    # {"name" => "...", "city" => "..."}
    def hello_profile_attributes
      attributes.slice(*self.class.hello_profile_column_names)
    end

    def password_entity
      identities.first
    end



    included do
      has_many :identities
      has_many :sessions

      validates_presence_of :name
    end



    module ClassMethods
      def roles
        [guest, user, admin]
      end

      def guest
        'guest'
      end

      def user
        'user'
      end

      def admin
        'admin'
      end

      # ['name', 'city']
      def hello_profile_column_names
        ignore_columns = ['id', 'created_at', 'updated_at', 'role']
        the_columns = column_names - ignore_columns
        the_columns.reject { |column| column.ends_with? '_count' }
      end
    end


  end
end