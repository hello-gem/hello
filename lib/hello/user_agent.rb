module Hello
  # 
  # https://github.com/toolmantim/user_agent_parser
  #

  # Instantiate the parser on load as it's quite expensive
  USER_AGENT_PARSER = UserAgentParser::Parser.new

  def self.user_agent_parser
    USER_AGENT_PARSER
  end

end
