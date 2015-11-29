# this model was created with the objective of testing account cancel
class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :text, :user
end
