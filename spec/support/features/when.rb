


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
    click_button 'Continue'
  end
end

def when_sign_up_with_standard_data(options={})
  when_sign_up_as_a_novice(expect_success: true)

  click_button "Continue"
  # expect(current_path).to eq root_path
  expect(current_path).to eq '/hello/user' # because there is no root path in this app
end


def when_sign_up_as_a_novice(options={})
  # if options[:expect_welcome_mailer] === true
  #   Hello::RegistrationMailer.should_receive(:welcome).and_return(double("mailer", deliver: true))
  # elsif options[:expect_welcome_mailer] === false
  #   Hello::RegistrationMailer.should_not_receive(:welcome)
  # end

  visit hello.root_path
  within("form#new_sign_up") do
    fill_in 'sign_up_name',     with: 'James Pinto'
    fill_in 'sign_up_email',    with: 'foo@bar.com'
    fill_in 'sign_up_username', with: 'foobar'
    fill_in 'sign_up_password', with: 'foobar'
    fill_in 'sign_up_city',     with: 'OMG! I can customize Hello!'
    click_button 'Sign Up'
  end

  if options[:expect_success] === true
    expect(current_path).to eq('/novice')
  end
  
end

def when_sign_in_with_standard_data(options={})
  data = ['foobar', (options[:password] || 'foobar')]
  visit hello.root_path
  within("form#new_sign_in") do
    fill_in 'sign_in_login',    with: data[0]
    fill_in 'sign_in_password', with: data[1]
    check 'keep_me' if options[:keep_me]
    click_button 'Sign In'
  end
  __fetch_current_active_session
end

def when_sign_in_with_admin_data
  data = ['admin', 'admin']
  visit hello.root_path
  within("form#new_sign_in") do
    fill_in 'sign_in_login',    with: data[0]
    fill_in 'sign_in_password', with: data[1]
    click_button 'Sign In'
  end
  __fetch_current_active_session
end


def when_I_sign_out
  click_link 'Sign Out'
  __fetch_current_active_session
end

def when_I_confirm_my_credential_password(custom_password=nil)
  within("form") do
    fill_in 'credential_password', with: (custom_password || 'foobar')
    click_button 'Confirm Password'
  end
end

def sign_up_as_a_novice
  when_sign_up_as_a_novice(expect_success: true)
  __fetch_current_active_session
  expect(current_user.role).to eq('novice')
end

def sign_up_as_a_user
  when_sign_up_with_standard_data
  __fetch_current_active_session
  expect(current_user.role).to eq('user')
end

def sign_up_as_an_admin
  sign_up_as_a_user
  current_user.update! role: 'admin'
end


def sign_up_as_a(role)
  case role.to_sym
  when :guest  # nothing to do
  when :novice then sign_up_as_a_novice
  when :user   then sign_up_as_a_user
  when :admin  then sign_up_as_an_admin
  else raise("Role #{role} is unknown")
  end
end

