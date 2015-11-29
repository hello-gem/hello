class Credential < ActiveRecord::Base
  # this model was created with the objective of testing account cancel
  has_many :some_credential_data, dependent: :restrict_with_error
end
