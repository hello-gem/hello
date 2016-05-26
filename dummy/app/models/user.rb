class User < Hello::RailsActiveRecord::User
  include Authorization

  def to_param
    username
  end


  has_many :facebook_credentials



  validates_presence_of :name
  has_many :addresses, dependent: :restrict_with_error

end
