class User < ActiveRecord::Base
  include Hello::ActiveRecordConcerns::User

  validates_presence_of :city

end
