
USER_TEST_EMAIL    = 'foo@bar.com'
USER_TEST_USERNAME = 'foobar'
USER_TEST_PASSWORD = 'foobar'

def given_I_have_a_classic_access_token
  user = create(:user, name: 'James Pinto', username: USER_TEST_USERNAME, password: USER_TEST_PASSWORD, city: 'Brasilia')
  credential = Credential.classic.create! user:     user,
                                          email:    USER_TEST_EMAIL
  AccessToken.create!(user: user, user_agent_string: 'testing', expires_at: 24.hours.from_now)
end

def given_I_have_a_classic_credential
  user = create(:user, name: 'James Pinto', username: USER_TEST_USERNAME, password: USER_TEST_PASSWORD, city: 'Brasilia')
  Credential.classic.create!  user:     user,
                              email:    USER_TEST_EMAIL
end

def given_I_have_a_novice_password_credential
  Credential.classic.create!  user:     create(:novice),
                              email:    USER_TEST_EMAIL
end

def given_I_have_a_master_password_credential
  Credential.classic.create!  user:     create(:master_user),
                              email:    'master@bar.com'
end

def given_I_have_a_classic_credential_and_forgot_my_password
  credential = given_I_have_a_classic_credential
  return unencrypted_token = credential.user.reset_password_token
end

def given_I_am_logged_in_with_a_classic_credential
  # when_sign_up_with_standard_data(expect_welcome_mailer: true)
  given_I_have_a_classic_credential
  when_sign_in_with_standard_data
  then_I_should_be_logged_in
end

def given_I_am_logged_in
  given_I_am_logged_in_with_a_classic_credential
end

