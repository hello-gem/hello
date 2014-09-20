class User < ActiveRecord::Base
  include Hello::UserModel

  validates_presence_of :city

  # this model was created with the objective of testing account deactivation
  has_many :addresses, dependent: :restrict_with_error

end
