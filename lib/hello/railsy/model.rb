require_relative "model/user"

require_relative "model/access"

class Access < ActiveRecord::Base
  include Hello::Access
end



require_relative "model/credential_model"

class Credential < ActiveRecord::Base
  include Hello::CredentialModel
end



require_relative "model/email_credential_model"

class EmailCredential < Credential
  include Hello::EmailCredentialModel
end


require_relative "model/password_credential_model"

class PasswordCredential < Credential
  include Hello::PasswordCredentialModel
end

