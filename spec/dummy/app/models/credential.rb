# programmers can override this file in their own projects :)
class Credential < ActiveRecord::Base
  include Hello::CredentialModel

  def encrypt_password(plain_text_password)
    salt     = "write-a-random-string-here"
    digestee = "#{plain_text_password}-#{salt}"
    Digest::MD5.hexdigest(digestee)
  end

  def password_is?(plain_text_password)
    password_digest == encrypt_password(plain_text_password)
  end

end
