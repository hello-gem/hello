# this model was created with the objective of testing account cancel
class SomeCredentialDatum < ActiveRecord::Base
  belongs_to :credential

  validates_presence_of :text, :credential
end
