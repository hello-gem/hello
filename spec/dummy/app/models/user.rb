class User < ActiveRecord::Base
  validates_presence_of :city

  # this model was created with the objective of testing account deactivation
  has_many :addresses, dependent: :restrict_with_error

  def to_param
    username
  end



  # hello authorization

  def guest?
    %w(guest).include? role
  end

  def onboarding?
    %w(onboarding).include? role
  end

  def user?
    %w(user webmaster).include? role
  end

  def webmaster?
    %w(webmaster).include? role
  end

end
