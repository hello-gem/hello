module Hello
  module AccessModel
    extend ActiveSupport::Concern

    def full_device_name
      obj = parsed_user_agent
      a_browser = obj.to_s
      a_os = obj.os.to_s
      a_browser = "#{obj.name} #{obj.version && obj.version.major}".strip
      a_os = "#{obj.os.name} #{obj.os.version && obj.os.version.major}".strip
      a_device = obj.device.name

      a_browser = a_browser.gsub("IE", "Internet Explorer") if a_browser.start_with? "IE"

      if a_device == "Other"
        "#{a_os} - #{a_browser}"
      elsif a_device == "Spider"
        "Spider: #{a_browser}"
      else
        "#{a_os} (#{a_device}) - #{a_browser}"
      end.strip
    end

    def parsed_user_agent
      Hello.user_agent_parser.parse(user_agent_string)
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
      def delete_all_expired
        where('expires_at < ?', Time.now).delete_all
        true
      end

      def cached_delete_all_expired
        @@delete_all_expired ||= delete_all_expired
      end
    end


  end
end