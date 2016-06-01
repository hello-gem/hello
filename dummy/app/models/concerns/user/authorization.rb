class User < Hello::RailsActiveRecord::User
  module Authorization

    def guest?
      %w(guest).include?(role)
    end

    def onboarding?
      %w(onboarding).include?(role)
    end

    def user?
      %w(user webmaster).include?(role)
    end

    def webmaster?
      %w(webmaster).include?(role)
    end

  end
end
