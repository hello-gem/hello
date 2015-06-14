class User < ActiveRecord::Base
  include Hello::UserModel # keep this line for gem hello

  # don't want usernames?
  # just comment out the line below
  # we strongly recommend the field exists in case your CEO ever ever ever changes their mind
  validates_presence_of :username

  # specify what happens to associated records when the user decided to terminate their account
  # has_many :things_to_destroy,  dependent: :destroy
  # has_many :things_to_nulify,   dependent: :nullify
  # has_many :things_to_restrict, dependent: :restrict_with_error



  # def sign_up_attribute_names
  #   %w(name username password time_zone locale)
  # end

  # def sign_up_default_attributes
  #   {
  #     locale:    I18n.locale.to_s,
  #     time_zone: Time.zone.name
  #   }
  # end
  
end
