
USER_TEST_EMAIL    = 'foo@bar.com'
USER_TEST_USERNAME = 'foobar'
USER_TEST_PASSWORD = 'foobar'

def given_I_have_a_classic_access_token
  user = create(:user, name: 'James Pinto', username: USER_TEST_USERNAME, password: USER_TEST_PASSWORD, city: 'Brasilia')
  create(:email_credential, user: user, email: USER_TEST_EMAIL)
  Access.create!(user: user, user_agent_string: 'testing', expires_at: 24.hours.from_now)
end

def given_I_have_an_email_credential
  user = create(:user, name: 'James Pinto', username: USER_TEST_USERNAME, password: USER_TEST_PASSWORD, city: 'Brasilia')
  create(:email_credential, user: user, email: USER_TEST_EMAIL)
end

def given_I_have_an_onboarding_password_credential
  user = create(:onboarding)
  create(:email_credential, user: user, email: USER_TEST_EMAIL)
end

def given_I_have_a_webmaster_password_credential
  user = create(:webmaster_user)
  create(:email_credential, user: user, email: 'webmaster@bar.com')
end

def given_I_have_an_email_credential_and_forgot_my_password
  credential = given_I_have_an_email_credential
  return unencrypted_token = credential.user.reset_password_token
end

def given_I_am_logged_in_with_a_classic_credential
  # when_sign_up_with_standard_data(expect_welcome_mailer: true)
  given_I_have_an_email_credential
  when_sign_in_with_standard_data
  then_I_should_be_logged_in
end

def given_I_am_logged_in
  given_I_am_logged_in_with_a_classic_credential
end

def given_I_am_logged_in_with_two_accounts
  given_I_have_signed_in
  given_I_have_a_webmaster_password_credential
  when_sign_in_with_webmaster_data
  then_I_expect_to_be_signed_in_with_role('webmaster')
  expect_to_see "dummy-accounts-2"
end

