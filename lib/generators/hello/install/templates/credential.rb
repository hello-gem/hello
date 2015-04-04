class Credential < ActiveRecord::Base
  include Hello::CredentialModel # keep this line for gem hello

  # specify what happens to associated records when the user decided to terminate their account
  # has_many :things_to_destroy,  dependent: :destroy
  # has_many :things_to_nulify,   dependent: :nullify
  # has_many :things_to_restrict, dependent: :restrict_with_error

end
