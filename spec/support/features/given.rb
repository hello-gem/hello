


def given_I_have_a_classic_access_token
  # puts "TODO: Credentials are no longer necessary for Sign In Feature".red
  user = create(:user, name: 'James Pinto', username: 'foobar', password: 'foobar', city: 'Brasilia')
  credential = Credential.classic.create! user:     user,
                                          email:    'foo@bar.com'
  AccessToken.create!(user: user, user_agent_string: 'testing', expires_at: 24.hours.from_now)
end

def given_I_have_a_classic_credential
  # puts "TODO: Credentials are no longer necessary for Sign In Feature".red
  user = create(:user, name: 'James Pinto', username: 'foobar', password: 'foobar', city: 'Brasilia')
  Credential.classic.create!  user:     user,
                              email:    'foo@bar.com'
end

def given_I_have_an_admin_password_credential
  # puts "TODO: Credentials are no longer necessary for Sign In Feature".red
  Credential.classic.create!  user:     create(:admin_user),
                              email:    'admin@bar.com'
end

def given_I_have_a_classic_credential_and_forgot_my_password
  # puts "TODO: Credentials are no longer necessary for Sign In Feature".red
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

