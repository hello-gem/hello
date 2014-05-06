class Credential < ActiveRecord::Base
  include Hello::CredentialModel

  def encrypt_password(plain_text_password)
    Digest::MD5.hexdigest(plain_text_password)
  end

  def password_is?(plain_text_password)
    password_digest == encrypt_password(plain_text_password)
  end

end
