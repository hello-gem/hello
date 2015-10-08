module Hello
  module AccessModel
    extend ActiveSupport::Concern

    def full_device_name
      Hello::DeviceName.instance.parse(user_agent_string)
    end

    def active_token_or_destroy
      if expires_at.future?
        token
      else
        destroy and return nil
      end
    end



    included do
      belongs_to :user, counter_cache: true

      validates_presence_of :user, :expires_at, :user_agent_string, :token
      validates_uniqueness_of :token

      before_validation on: :create do
        self.token = "#{user_id}-#{Token.single(16)}"
      end
    end



    #
    # JSON
    #
    def to_json_web_api
      hash = attributes.slice(*%w[expires_at token user_id])
      hash.merge!({user: user.to_json_web_api})
    end


    module ClassMethods
      def destroy_all_expired
        where('expires_at < ?', Time.now).destroy_all
        true
      end

      def cached_destroy_all_expired
        @@destroy_all_expired ||= destroy_all_expired
      end
    end


  end
end
