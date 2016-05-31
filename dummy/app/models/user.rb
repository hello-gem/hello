class User < Hello::RailsActiveRecord::User
  include HelloMixin

  validates_presence_of :name
  validates_presence_of :city
  has_many :addresses, dependent: :restrict_with_error

end
