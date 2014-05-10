# programmers can override this file in their own projects :)
class Session < ActiveRecord::Base
  include Hello::SessionModel

  def device_name
    ua
  end
end
