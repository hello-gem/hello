# Cannot be named ActiveRecord or will compete with ::ActiveRecord
module Hello::RailsActiveRecord
end

require_relative 'rails_active_record/user'
User = Class.new(Hello::RailsActiveRecord::User)

require_relative 'rails_active_record/access'
Access = Class.new(Hello::RailsActiveRecord::Access)

require_relative 'rails_active_record/credential'
Credential = Class.new(Hello::RailsActiveRecord::Credential)

require_relative 'rails_active_record/email_credential'
EmailCredential = Class.new(Hello::RailsActiveRecord::EmailCredential)

require_relative 'rails_active_record/password_credential'
PasswordCredential = Class.new(Hello::RailsActiveRecord::PasswordCredential)
