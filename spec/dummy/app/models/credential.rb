# programmers can override this file in their own projects :)
class Credential < ActiveRecord::Base
  include Hello::CredentialModel

  # this model was created with the objective of testing account deactivation
  has_many :some_credential_data, dependent: :restrict_with_error
end
