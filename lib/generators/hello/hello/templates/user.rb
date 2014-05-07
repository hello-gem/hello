# programmers can override this file in their own projects :)
class User < ActiveRecord::Base
  include Hello::UserModel
end
