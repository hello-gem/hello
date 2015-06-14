module Hello
  module UserModel
    extend ActiveSupport::Concern


    # {"name" => "...", "city" => "..."}
    def hello_profile_attributes
      attributes.slice(*self.class.hello_profile_column_names)
    end

    def novice?
      role == self.class.novice
    end

    def admin?
      role == self.class.admin
    end

    def to_hash_profile
      attributes.reject { |key| %w[password_digest password_token_digest password_token_digested_at].include? key }
    end

    included do
      has_many :credentials,     dependent: :destroy
      has_many :access_tokens, dependent: :destroy

      validates_presence_of :name, :locale, :time_zone
      validates_inclusion_of :locale,    in: Hello.available_locales
      validates_inclusion_of :time_zone, in: Hello.available_time_zones

      include UserModelUsername
      include UserModelPassword
    end

    def destroy
      # In Rails 4.0
      # 'this instance' and the 'user in the credential instance'
      # are 2 separate instances, making it impossible for them to share state
      # therefore, an instance variable used as a flag will not work for Rails 4.0
      # It will however, work for Rails 4.1 and 4.2
      # @hello_is_this_being_destroyed = true 
      Thread.current["Hello.destroying_user"] = true
      super
    end

    # def hello_is_this_being_destroyed?
    #   !!@hello_is_this_being_destroyed
    # end



    def sign_up_attribute_names
      %w(name username password time_zone locale)
    end

    def sign_up_default_attributes
      {
        locale:    I18n.locale.to_s,
        time_zone: Time.zone.name
      }
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
        the_columns.reject! { |column| column.ends_with? '_count' }
        the_columns.reject! { |column| column.starts_with? 'password_' }
        the_columns
      end
    end


  end
end