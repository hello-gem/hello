


def when_I_update_a_reset_password_form_with(password)
  within("form") do
    fill_in 'registration_reset_password', with: (password)
    click_button 'Save'
  end
end

def when_I_ask_to_reset_my_password(custom_login=nil)
  visit hello.root_path
  click_link "Forgot"
  within("form") do
    fill_in 'registration_forgot_login', with: (custom_login || 'foobar')
    click_button 'Ask to reset my password'
  end
end

def when_sign_up_with_standard_data
  visit hello.root_path
  within("form#new_registration_sign_up") do
    fill_in 'registration_sign_up_name',     with: 'James Pinto'
    fill_in 'registration_sign_up_email',    with: 'foo@bar.com'
    fill_in 'registration_sign_up_username', with: 'foobar'
    fill_in 'registration_sign_up_password', with: 'foobar'
    fill_in 'registration_sign_up_city',     with: 'OMG! I can customize Hello!'
    click_button 'Sign Up'
  end
end

def when_sign_in_with_standard_data(custom_password=nil)
  visit hello.root_path
  within("form#new_registration_sign_in") do
    fill_in 'registration_sign_in_login',    with: 'foobar'
    fill_in 'registration_sign_in_password', with: (custom_password || 'foobar')
    click_button 'Sign In'
  end
end


