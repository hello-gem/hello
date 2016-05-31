class User < Hello::RailsActiveRecord::User

  validates_presence_of :name

  def to_param
    username
  end

  def as_json_web_api
    attributes
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
end
