# Hello Gem: this file may be removed if you don't need to customize it
class Access < ActiveRecord::Base
  # specify what happens to associated records when the user decided to terminate their account
  # has_many :things_to_destroy,  dependent: :destroy
  # has_many :things_to_nulify,   dependent: :nullify
  # has_many :things_to_restrict, dependent: :restrict_with_error
end
