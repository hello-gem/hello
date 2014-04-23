module Hello
  module ActiveRecordConcerns
    module User

      extend ActiveSupport::Concern

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
      end

    end
  end
end
