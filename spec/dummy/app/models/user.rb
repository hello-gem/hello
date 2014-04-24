class User < ActiveRecord::Base
  include Hello::ActiveRecordConcerns::User

end
