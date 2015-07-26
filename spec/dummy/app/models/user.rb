class User < ActiveRecord::Base
  include Hello::UserModel

  validates_presence_of :city

  # this model was created with the objective of testing account deactivation
  has_many :addresses, dependent: :restrict_with_error

  def sign_up_attribute_names
    %w(name username password time_zone locale city)
  end

  def to_param
    username
  end
  
end
