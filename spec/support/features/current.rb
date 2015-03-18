
def __fetch_current_active_session
  @current_access_token = AccessToken.last
end

def current_access_token
  @current_access_token
end

def last_credential
  Credential.last
end

def current_user
  current_access_token.user
end

