module Hello
  module User
    module Username
      extend ActiveSupport::Concern

      included do
        validates_presence_of   :username
        validates_uniqueness_of :username

        validate :hello_validations_username
      end

      def username=(v)
        super(v.to_s.downcase.remove(' '))
      end

      def set_generated_username
        loop do
          self.username = _make_up_new_username
          break if _username_unique?
        end
      end

      private

      def hello_validations_username
        c = Hello.configuration
        validates_format_of :username, with: c.username_regex
        validates_length_of :username, in:   c.username_length
      end

      def _make_up_new_username
        Token.single(16)
      end

      def _username_unique?
        not self.class.unscoped.where(username: username).where.not(id: id).exists?
      end






      # def username_suggestions
      #   email1 = email.to_s.split('@').first
      #   name1  = name.to_s.split(' ')
      #   ideas = [name1, email1].flatten
      #   [ideas.sample, rand(999)].join.parameterize
      # end

    end
  end
end
