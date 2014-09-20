# this model was created with the objective of testing account deactivation
class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :text
end
