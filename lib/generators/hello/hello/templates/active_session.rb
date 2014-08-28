# programmers can override this file in their own projects :)
class ActiveSession < ActiveRecord::Base
  include Hello::ActiveSessionModel

end
