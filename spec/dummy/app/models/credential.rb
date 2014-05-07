# programmers can override this file in their own projects :)
class Credential < ActiveRecord::Base
  include Hello::CredentialModel

  def encrypt_password(plain_text_password)
    # sample salt strategy
    salt     = "write-a-random-string-here"
    digestee = "#{plain_text_password}-#{salt}"
    Digest::MD5.hexdigest(digestee)
  end

end
