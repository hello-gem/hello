require "hello/rails/model/user_model"
require "hello/rails/model/credential_model"
require "hello/rails/model/access_token_model"

class User < ActiveRecord::Base
  include Hello::UserModel
end

class Credential < ActiveRecord::Base
  include Hello::CredentialModel
end

class AccessToken < ActiveRecord::Base
  include Hello::AccessTokenModel
end
