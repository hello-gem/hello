# module Hello
  class Identity < ActiveRecord::Base
    module Twitter
      extend ActiveSupport::Concern




#https://github.com/arunagw/omniauth-twitter/blob/master/lib/omniauth/strategies/twitter.rb




      # included do
      #   validates_presence_of :email, :password, if: :is_password?

      #   # email
      #   validates_email_format_of :email, if: :is_password?
      #   validates_uniqueness_of :email,
      #                           message: 'already exists',
      #                           if: :is_password?


      #   puts "username should be unique too".on_red
      #   # password
      #   validates_length_of :password,
      #                       in: 4..200,
      #                       too_long: 'pick a longer password',
      #                       too_short: 'pick a shorter password',
      #                       if: :is_password?
      # end


      # def is_password?
      #   strategy.to_s.inquiry.password?
      # end



      module ClassMethods
      end






      private







    end
  end
# end
