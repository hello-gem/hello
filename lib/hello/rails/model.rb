require "hello/rails/model/user_model"

class User < ActiveRecord::Base
  include Hello::UserModel
end



require "hello/rails/model/access_model"

class Access < ActiveRecord::Base
  include Hello::AccessModel
end



require "hello/rails/model/credential_model"

class Credential < ActiveRecord::Base
  include Hello::CredentialModel
end



require "hello/rails/model/email_credential_model"

class EmailCredential < Credential
  include Hello::EmailCredentialModel
end
