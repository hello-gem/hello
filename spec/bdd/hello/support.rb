
def fill_in_registration_form
  within("form#new_sign_up") do
    fill_in 'sign_up_name',     with: 'James Pinto'
    fill_in 'sign_up_email',    with: 'foo@bar.com'
    fill_in 'sign_up_username', with: 'foobar'
    fill_in 'sign_up_password', with: '1234'
    fill_in 'sign_up_city',     with: 'OMG! I can customize Hello!'
  end
end

def fill_in_login_form(username, password='1234')
  within("form#new_sign_in") do
    fill_in 'sign_in_login',    with: username
    fill_in 'sign_in_password', with: password
  end
end

def sign_in_as_an_onboarding
  u = create(:user_onboarding)
  create(:email_credential, user: u, email: "#{u.username}@example.com")
  visit '/hello/sign_in'
  fill_in_login_form('onboarding')
  click_button 'Sign In'
  __fetch_current_access
  expect(current_user.role).to eq('onboarding')
end

def sign_in_as_a_user
  u = create(:user_user)
  create(:email_credential, user: u, email: "#{u.username}@example.com")
  visit '/hello/sign_in'
  fill_in_login_form('user')
  click_button 'Sign In'
  __fetch_current_access
  expect(current_user.role).to eq('user')
end

def sign_in_as_a_webmaster
  u = create(:user_webmaster)
  create(:email_credential, user: u, email: "#{u.username}@example.com")
  visit '/hello/sign_in'
  fill_in_login_form('webmaster')
  click_button 'Sign In'
  __fetch_current_access
  expect(current_user.role).to eq('webmaster')
end


def sign_in_as_a(role)
  case role.to_sym
  when :guest  # nothing to do
  when :onboarding then sign_in_as_an_onboarding
  when :user       then sign_in_as_a_user
  when :webmaster  then sign_in_as_a_webmaster
  else raise("Role #{role} is unknown")
  end
end

