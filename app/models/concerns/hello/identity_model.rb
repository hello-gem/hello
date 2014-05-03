module Hello
  module IdentityModel
    extend ActiveSupport::Concern

    included do
      belongs_to :user, counter_cache: true
      validates_presence_of :user

      scope :strategy_password, -> { where(strategy: password) }

      validates_presence_of :strategy
      validates_inclusion_of :strategy, in: strategies

      # concerns
      include Password
      # include Twitter
    end


    module ClassMethods
      def strategies
        [password, twitter]
      end

      def password
        'password'
      end

      def twitter
        'twitter'
      end
    end

  end
end