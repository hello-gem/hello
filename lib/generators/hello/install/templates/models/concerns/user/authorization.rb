class User < Hello::RailsActiveRecord::User
  module Authorization

    def role_is?(string)
      case string.to_s
      when 'guest'
        %w(guest).include?(role)
      when 'onboarding'
        %w(onboarding).include?(role)
      when 'user'
        %w(user webmaster).include?(role)
      when 'webmaster'
        %w(webmaster).include?(role)
      end
    end

  end
end
