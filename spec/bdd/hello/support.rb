
def fill_in_registration_form
  within("form#new_sign_up") do
    fill_in 'sign_up_name',     with: 'James Pinto'
    fill_in 'sign_up_email',    with: 'foo@bar.com'
    fill_in 'sign_up_username', with: 'foobar'
    fill_in 'sign_up_password', with: '1234'
  end
end

def fill_in_login_form(username, password='1234')
  within("form#new_sign_in") do
    fill_in 'sign_in_login',    with: username
    fill_in 'sign_in_password', with: password
  end
end

def sign_in_with(login, password='1234')
  visit '/hello/sign_in'
  fill_in_login_form(login, password)
  click_button 'Sign In'
  click_link 'expire'
  __fetch_current_access
end

def sign_in_as_an_onboarding
  u = create(:user_onboarding)
  sign_in_with(u.username)
  expect(current_user.role).to eq('onboarding')
end

def sign_in_as_a_user
  u = create(:user_user)
  sign_in_with(u.username)
  expect(current_user.role).to eq('user')
end

def sign_in_as_a_webmaster
  u = create(:user_webmaster)
  sign_in_with(u.username)
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

def visit_path_after(path, delay)
  current_access.update expires_at: (current_access.expires_at - delay + 1.second)
  visit path
end

