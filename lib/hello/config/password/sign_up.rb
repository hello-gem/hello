module Hello
  class Config
    class SignUp < Base
      has_scopes :success, :error
    end
  end
end
