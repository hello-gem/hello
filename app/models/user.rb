class User < ActiveRecord::Base
  # programmers can override this file in their own projects :)
  include Hello::ActiveRecordConcerns::User
end
