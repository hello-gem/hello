class Credential < ActiveRecord::Base
  include Hello::CredentialModel

  def encrypt_password(plain_text_password)
    Digest::MD5.hexdigest(plain_text_password)
  end

end
