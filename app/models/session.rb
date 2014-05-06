class Session < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :credential, counter_cache: true

  validates_presence_of :credential, :user, :ua

  before_validation on: :create do
    self.user = credential && credential.user
  end
end
