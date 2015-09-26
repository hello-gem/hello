
def when_I_ask_to_reset_my_password(custom_login=nil)
  visit hello.root_path
  click_link "Forgot"
  within("form") do
    fill_in 'forgot_password_login', with: (custom_login || 'foobar')
    click_button 'Continue'
  end
end

def when_sign_up_with_standard_data(options={})
  when_sign_up_as_an_onboarding(expect_success: true)

  click_button "Continue"
  # expect(current_path).to eq root_path
  expect(current_path).to eq '/hello/user' # because there is no root path in this app
end


def when_sign_up_as_an_onboarding(options={})
  # if options[:expect_welcome_mailer] === true
  #   Hello::RegistrationMailer.should_receive(:welcome).and_return(double("mailer", deliver: true))
  # elsif options[:expect_welcome_mailer] === false
  #   Hello::RegistrationMailer.should_not_receive(:welcome)
  # end

  # visit hello.root_path
  visit hello.sign_up_path
  within("form#new_sign_up") do
    fill_in 'sign_up_name',     with: 'James Pinto'
    fill_in 'sign_up_email',    with: 'foo@bar.com'
    fill_in 'sign_up_username', with: 'foobar'
    fill_in 'sign_up_password', with: 'foobar'
    fill_in 'sign_up_city',     with: 'OMG! I can customize Hello!'
    click_button 'Sign Up'
  end

  if options[:expect_success] === true
    expect(current_path).to eq('/onboarding')
  end
  
end

def when_sign_in_with_standard_data(options={})
  when_sign_in('foobar', (options[:password] || 'foobar'), options)
end

def when_sign_in_with_webmaster_data
  when_sign_in('webmaster', 'webmaster')
end

def when_sign_in(login, password, options={})
  # visit hello.root_path
  visit hello.sign_in_path
  within("form#new_sign_in") do
    fill_in 'sign_in_login',    with: login
    fill_in 'sign_in_password', with: password
    check 'keep_me' if options[:keep_me]
    click_button 'Sign In'
  end
  __fetch_current_access
end


def when_I_sign_out
  click_link 'Sign Out'
  __fetch_current_access
end

def when_I_confirm_my_user_password(custom_password=nil, expect_to_be_valid=true)
  # expect(current_path).to eq '/hello/sudo'
  expect_to_see "Confirm Password to Continue"
  within("form") do
    fill_in 'user_password', with: (custom_password || 'foobar')
    click_button 'Confirm Password'
  end
  if expect_to_be_valid
    expect_flash_notice "Now we know it's really you. We won't be asking your password again for 60 minutes"
  end
end

def when_I_confirm_sudo_mode(custom_password=nil)
  when_I_confirm_my_user_password(custom_password)
end

def sign_up_as_an_onboarding
  when_sign_up_as_an_onboarding(expect_success: true)
  __fetch_current_access
  expect(current_user.role).to eq('onboarding')
end

def sign_up_as_a_user
  when_sign_up_with_standard_data
  __fetch_current_access
  expect(current_user.role).to eq('user')
end

def sign_up_as_a_webmaster
  sign_up_as_a_user
  current_user.update! role: 'webmaster'
end


def sign_up_as_a(role)
  case role.to_sym
  when :guest  # nothing to do
  when :onboarding then sign_up_as_an_onboarding
  when :user   then sign_up_as_a_user
  when :webmaster  then sign_up_as_a_webmaster
  else raise("Role #{role} is unknown")
  end
end

