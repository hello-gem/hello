module Hello
  module UserModel
    extend ActiveSupport::Concern


    # {"name" => "...", "city" => "..."}
    def hello_profile_attributes
      attributes.slice(*self.class.hello_profile_column_names)
    end

    def classic_credential
      credentials.classic.first
    end

    def novice?
      role == self.class.novice
    end

    def admin?
      role == self.class.admin
    end

    def to_hash_profile
      attributes
    end

    included do
      has_many :credentials,     dependent: :destroy
      has_many :access_tokens, dependent: :destroy

      validates_presence_of :name, :locale, :time_zone
      validates_inclusion_of :locale,    in: Hello.available_locales
      validates_inclusion_of :time_zone, in: Hello.available_time_zones
    end





    module ClassMethods
      def roles
        [guest, novice, user, admin]
      end

      def guest
        'guest'
      end

      def novice
        'novice'
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