



def given_I_have_a_password_identity
  Identity.create!  strategy: Identity.password,
                    user:     User.create!(name: 'James Pinto', city: 'Brasilia'),
                    email:    'foo@bar.com',
                    username: 'foobar',
                    password: 'foobar'
end

def given_I_have_a_password_identity_and_forgot_my_password
  identity = given_I_have_a_password_identity
  return unencrypted_token = identity.reset_password_token
end

def given_I_am_logged_in
  when_sign_up_with_standard_data
  when_sign_in_with_standard_data
  then_I_should_be_logged_in
end

