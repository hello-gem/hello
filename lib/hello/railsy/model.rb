require_relative "model/user"
require_relative "model/access"
require_relative "model/credential"
require_relative "model/email_credential"
require_relative "model/password_credential"

# class User must be declared in the app so as to avoid auto load intermittent issues

class Access < ActiveRecord::Base
  include Hello::Access
end

class Credential < ActiveRecord::Base
  include Hello::Credential
end

class EmailCredential < Credential
  include Hello::EmailCredential
end

class PasswordCredential < Credential
  include Hello::PasswordCredential
end
