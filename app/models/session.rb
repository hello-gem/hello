class Session < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :identity, counter_cache: true

  validates_presence_of :identity, :user, :ua

  before_validation on: :create do
    self.user = identity && identity.user
  end
end
