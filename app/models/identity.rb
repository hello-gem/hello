class Identity < ActiveRecord::Base

  belongs_to :user, counter_cache: true
  validates_presence_of :user

    def self.strategies
      [password, twitter]
    end

    def self.password
      'password'
    end

    def self.twitter
      'twitter'
    end

    scope :strategy_password, -> { where(strategy: password) }

  validates_presence_of :strategy
  validates_inclusion_of :strategy, in: strategies

  # concerns
  include Password
  # include Twitter

  def password_is?(unencrypted_password)
    password == unencrypted_password
  end






  private










end
