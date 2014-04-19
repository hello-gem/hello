module Hello
  class Identity < ActiveRecord::Base
    module Password
      extend ActiveSupport::Concern

      included do
        validates_presence_of :email, :password, if: :is_password?

        # email
        validates_email_format_of :email, if: :is_password?
        validates_uniqueness_of :email,
                                message: 'already exists',
                                if: :is_password?


        puts "username should be unique too".on_red
        # password
        validates_length_of :password,
                            in: 4..200,
                            too_long: 'pick a longer password',
                            too_short: 'pick a shorter password',
                            if: :is_password?
      end


      def is_password?
        strategy.to_s.inquiry.password?
      end



      module ClassMethods
      end


      def should_reset_token?
        token_digested_at.blank? || token_digested_at < 7.days.ago
      end

      def reset_token
        uuid = SecureRandom.hex(8) # probability = 1 / (16 ** 16)
        digest = Digest::MD5.hexdigest(uuid)
        update(token_digest: digest, token_digested_at: 1.second.ago)
        return uuid
      end


      private







    end
  end
end