module Hello
  class Config
    class SignUp < Base
      has_scopes :success, :error
      has_fields
    end
  end
end
