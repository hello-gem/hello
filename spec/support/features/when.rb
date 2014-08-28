


def when_I_update_a_reset_password_form_with(password)
  within("form") do
    fill_in 'reset_password_password', with: (password)
    click_button 'Save'
  end
end

def when_I_ask_to_reset_my_password(custom_login=nil)
  visit hello.root_path
  click_link "Forgot"
  within("form") do
    fill_in 'forgot_password_login', with: (custom_login || 'foobar')
    click_button 'Reset'
  end
end

def when_sign_up_with_standard_data(options={})
  if options[:expect_welcome_mailer] === true
    Hello::RegistrationMailer.should_receive(:welcome).and_return(double("mailer", deliver: true))
  elsif options[:expect_welcome_mailer] === false
    Hello::RegistrationMailer.should_not_receive(:welcome)
  end

  visit hello.root_path
  within("form#new_sign_up") do
    fill_in 'sign_up_name',     with: 'James Pinto'
    fill_in 'sign_up_email',    with: 'foo@bar.com'
    fill_in 'sign_up_username', with: 'foobar'
    fill_in 'sign_up_password', with: 'foobar'
    fill_in 'sign_up_city',     with: 'OMG! I can customize Hello!'
    click_button 'Sign Up'
  end
end

def when_sign_in_with_standard_data(options={})
  visit hello.root_path
  within("form#new_sign_in") do
    fill_in 'sign_in_login',    with: 'foobar'
    fill_in 'sign_in_password', with: (options[:password] || 'foobar')
    check 'keep_me' if options[:keep_me]
    click_button 'Sign In'
  end
end

def when_sign_in_with_admin_data
  visit hello.root_path
  within("form#new_sign_in") do
    fill_in 'sign_in_login',    with: 'admin'
    fill_in 'sign_in_password', with: 'admin'
    click_button 'Sign In'
  end
end


def when_I_sign_out
  click_link 'Sign Out'
end

def when_I_confirm_my_credential_password(custom_password=nil)
  within("form") do
    fill_in 'credential_password', with: (custom_password || 'foobar')
    click_button 'Confirm Password'
  end
end





