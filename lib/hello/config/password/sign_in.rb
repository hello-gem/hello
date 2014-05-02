module Hello
  class Config
    class SignIn < Base
      has_scopes :success, :error
    end
  end
end
