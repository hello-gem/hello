class User < ApplicationRecord
  include Hello::RailsActiveRecord::User
  include Authorization

  def to_param
    username
  end

  validates_presence_of :name
  has_many :addresses, dependent: :restrict_with_error

end
