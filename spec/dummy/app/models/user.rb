class User < ActiveRecord::Base
  include Hello::UserModel

  validates_presence_of :city

end
