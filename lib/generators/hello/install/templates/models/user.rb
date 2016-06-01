class User < Hello::RailsActiveRecord::User
  include Authorization

  def to_param
    username
  end

  validates_presence_of :name
end
