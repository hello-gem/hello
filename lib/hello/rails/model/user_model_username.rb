module Hello
  module UserModelUsername
    extend ActiveSupport::Concern


    included do
      before_validation :ensure_username_if_blank_allowed_on_create, on: :create


      # username
      validates_uniqueness_of :username
    end





    module ClassMethods
    end



    #
    # downcase setters
    #

    def username=(v)
      v = v.to_s.downcase.gsub(' ', '')
      write_attribute(:username, v)
    end






    def ensure_username_if_blank_allowed_on_create
      return true if username.present?              # skip if username has been set
      return true if username_presence_is_required? # skip if username presence is required
      
      loop do
        self.username = make_up_new_username
        break unless username_used_by_another?(username)
      end
    end

        def make_up_new_username
          Token.single(16)
        end

        def username_used_by_another?(a_username)
          self.class.where(username: a_username).where.not(id: id).exists?
        end

        def username_presence_is_required?
          _validators[:username].map(&:class).include? ActiveRecord::Validations::PresenceValidator
        end






    # def username_suggestions
    #   email1 = email.to_s.split('@').first
    #   name1  = name.to_s.split(' ')
    #   ideas = [name1, email1].flatten
    #   [ideas.sample, rand(999)].join.parameterize
    # end


  end
end