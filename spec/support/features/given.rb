



def given_I_have_a_password_credential
  Credential.classic.create!  user:     User.create!(name: 'James Pinto', city: 'Brasilia'),
                            email:    'foo@bar.com',
                            username: 'foobar',
                            password: 'foobar'
end

def given_I_have_a_password_credential_and_forgot_my_password
  credential = given_I_have_a_password_credential
  return unencrypted_token = credential.reset_password_token
end

def given_I_am_logged_in
  when_sign_up_with_standard_data
  when_sign_in_with_standard_data
  then_I_should_be_logged_in
end

