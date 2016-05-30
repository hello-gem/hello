# Cannot be named ActiveRecord or will compete with ::ActiveRecord
module Hello
  module RailsActiveRecord
    autoload :User,               'hello/rails_active_record/user'
    autoload :Credential,         'hello/rails_active_record/credential'
    autoload :EmailCredential,    'hello/rails_active_record/email_credential'
    autoload :PasswordCredential, 'hello/rails_active_record/password_credential'
    autoload :Access,             'hello/rails_active_record/access'
  end
end
