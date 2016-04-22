module Hello::Utils
  class DeviceName
    # https://github.com/toolmantim/user_agent_parser
    # Instantiate the parser on load as it's quite expensive
    include Singleton

    def parse(user_agent_string)
      obj = user_agent_parser.parse(user_agent_string)
      a_browser = obj.to_s
      a_os = obj.os.to_s
      a_browser = "#{obj.name} #{obj.version && obj.version.major}".strip
      a_os = "#{obj.os.name} #{obj.os.version && obj.os.version.major}".strip
      a_device = obj.device.name

      a_browser = a_browser.gsub('IE', 'Internet Explorer') if a_browser.start_with? 'IE'

      if a_device == 'Other'
        "#{a_os} - #{a_browser}"
      elsif a_device == 'Spider'
        "Spider: #{a_browser}"
      else
        "#{a_os} (#{a_device}) - #{a_browser}"
      end.strip
    end

    def user_agent_parser
      @uap = UserAgentParser::Parser.new
    end
  end
end
