


def when_I_update_a_password_form_with(password)
  within("form") do
    fill_in 'password', with: (password)
    click_button 'Save'
  end
end

def when_I_ask_to_reset_my_password(custom_login=nil)
  visit hello.root_path
  click_link "Forgot"
  within("form") do
    fill_in 'login', with: (custom_login || 'foobar')
    click_button 'Ask to reset my password'
  end
end

def when_sign_up_with_standard_data
  visit hello.root_path
  within("form") do
    fill_in 'name',     with: 'James Pinto'
    fill_in 'email',    with: 'foo@bar.com'
    fill_in 'username', with: 'foobar'
    fill_in 'password', with: 'foobar'
    click_button 'Sign Up'
  end
end

def when_sign_in_with_standard_data(custom_password=nil)
  visit hello.root_path
  click_link "Sign In"
  within("form") do
    fill_in 'login',    with: 'foobar'
    fill_in 'password', with: (custom_password || 'foobar')
    click_button 'Sign In'
  end
end


