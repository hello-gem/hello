module Hello
  class Config
    class Forgot < Base
      has_scopes :success, :error
    end
  end
end
