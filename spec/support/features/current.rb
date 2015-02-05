
def __fetch_current_active_session
  @current_access_token = AccessToken.last
end

def current_access_token
  @current_access_token
end

def current_credential
  current_access_token.credential
end

def current_user
  current_credential.user
end

