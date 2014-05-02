module Hello
  class Config
    class Reset < Base
      has_scopes :success, :error
    end
  end
end
