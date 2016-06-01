module Hello
  module RailsActiveRecord
    class Access < ::ActiveRecord::Base
      self.table_name = 'accesses'

      # ASSOCIATIONS
      belongs_to :user, counter_cache: true, class_name: '::User'

      # VALIDATIONS
      validates_presence_of :user, :expires_at, :user_agent_string, :token
      validates_uniqueness_of :token

      before_validation on: :create do
        self.token = "#{user_id}-#{Hello::Encryptors::Simple.instance.single(16)}"
      end

      # CUSTOM METHODS

      def keep_alive!
        renew! if expiring?
      end

      def full_device_name
        Hello::Utils::DeviceName.instance.parse(user_agent_string)
      end

      def active_token_or_destroy
        if expires_at.future?
          token
        else
          destroy && (return nil)
        end
      end

      def as_json_web_api
        hash = attributes.slice(*%w(expires_at token user_id))
        hash.merge!({ user: user.as_json_web_api })
      end

      def sudo_expire!
        update! sudo_expires_at: 1.second.ago
      end

      private

      def expiring?
        expires_at < 20.minutes.from_now
      end

      def renew!
        update_attributes!(expires_at: 30.minutes.from_now)
      end

      class << self
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
end
