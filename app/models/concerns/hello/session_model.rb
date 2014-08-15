module Hello
  module SessionModel
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



    included do
      belongs_to :user, counter_cache: true
      belongs_to :credential, counter_cache: true

      validates_presence_of :credential, :user, :expires_at, :user_agent_string, :access_token
      validates_uniqueness_of :access_token

      before_validation on: :create do
        self.user = credential && credential.user
        self.access_token = SecureRandom.hex(16) # probability = 1 / (32 ** 32)
      end
    end



    #
    # JSON
    #
    def as_json_api
      base_attrs = {}
      base_attrs.merge!(attributes.slice(*%w[expires_at access_token user_id]))
      base_attrs.merge!(credential.attributes.slice(*%w[username email email_confirmed_at]))
      base_attrs.merge!({user: user.to_hash_profile})
      base_attrs
    end


    module ClassMethods
    end


  end
end