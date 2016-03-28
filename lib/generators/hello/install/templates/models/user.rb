# Everything you need to know about customizing Hello
#
# https://github.com/hello-gem/hello/tree/master/FAQ/HOW-TO
class User < ActiveRecord::Base
  include Hello::User

  # specify what happens to associated records when the user decided to terminate their account
  # has_many :things_to_destroy,  dependent: :destroy
  # has_many :things_to_nulify,   dependent: :nullify
  # has_many :things_to_restrict, dependent: :restrict_with_error

  validates_presence_of :name

  def to_param
    username
  end

  def as_json_web_api
    attributes
  end

  # hello account management

  def cancel_account
    result = true
    transaction do
      begin
        destroy!
      rescue ActiveRecord::RecordNotDestroyed => invalid
        result = false
        raise ActiveRecord::Rollback
      end
    end
    result
  end
end
