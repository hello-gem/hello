class User < Hello::RailsActiveRecord::User
  include HelloMixin

  validates_presence_of :name
end
