class User < Hello::RailsActiveRecord::User

  validates_presence_of :name

  def to_param
    username
  end

  # hello authorization

  def guest?
    %w(guest).include?(role)
  end

  def onboarding?
    %w(onboarding).include?(role)
  end

  def user?
    %w(user webmaster).include?(role)
  end

  def webmaster?
    %w(webmaster).include?(role)
  end

  # hello management

  def cancel_account
    destroy!
  rescue ActiveRecord::RecordNotDestroyed => invalid
    false
  end

  # dummy custom

  validates_presence_of :city
  has_many :addresses, dependent: :restrict_with_error
end
