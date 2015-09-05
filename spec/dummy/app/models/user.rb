class User < ActiveRecord::Base
  validates_presence_of :city

  # this model was created with the objective of testing account deactivation
  has_many :addresses, dependent: :restrict_with_error

  def to_param
    username
  end
  
end
