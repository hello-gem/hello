module Hello
  module SessionModel
    extend ActiveSupport::Concern

    def device_name
      ua
    end



    included do
      belongs_to :user, counter_cache: true
      belongs_to :credential, counter_cache: true

      validates_presence_of :credential, :user, :ua, :token
      validates_uniqueness_of :token

      before_validation on: :create do
        self.user = credential && credential.user
        self.token = SecureRandom.hex(16) # probability = 1 / (32 ** 32)
      end
    end



    #
    # JSON
    #
    def as_json_api
      base_attrs = {}
      base_attrs.merge!(attributes.slice(*%w[expires_at token]))
      base_attrs.merge!(credential.attributes.slice(*%w[username email email_confirmed_at]))
      base_attrs.merge!({user: user.to_hash_profile})
      base_attrs
    end


    module ClassMethods
    end


  end
end