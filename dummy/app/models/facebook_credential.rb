class FacebookCredential < Credential
  validates_presence_of :uid, :email
  validates_uniqueness_of :uid
end
