


def given_I_have_a_classic_active_session
  user = create(:user, name: 'James Pinto', city: 'Brasilia')
  credential = Credential.classic.create! user:     user,
                                          email:    'foo@bar.com',
                                          username: 'foobar',
                                          password: 'foobar'
  ActiveSession.create!(credential: credential, user_agent_string: 'testing', expires_at: 24.hours.from_now)
end

def given_I_have_a_classic_credential
  Credential.classic.create!  user:   create(:user, name: 'James Pinto', city: 'Brasilia'),
                            email:    'foo@bar.com',
                            username: 'foobar',
                            password: 'foobar'
end

def given_I_have_an_admin_password_credential
  Credential.classic.create!  user:   create(:admin_user),
                            email:    'admin@bar.com',
                            username: 'admin',
                            password: 'admin'
end

def given_I_have_a_classic_credential_and_forgot_my_password
  credential = given_I_have_a_classic_credential
  return unencrypted_token = credential.reset_password_token
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

