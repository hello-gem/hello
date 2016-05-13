module Hello
  module Encryptors
    autoload :MD5, 'hello/encryptors/md5'
    autoload :BCrypt, 'hello/encryptors/bcrypt'
  end
end
