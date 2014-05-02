module Hello
  class Config
    class User < Base
      has_scopes :success, :error
    end
  end
end
