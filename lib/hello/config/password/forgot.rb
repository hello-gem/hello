module Hello
  class Config
    class Forgot < Base
      has_scopes :success, :error, :deliver_password_forgot
    end
  end
end
