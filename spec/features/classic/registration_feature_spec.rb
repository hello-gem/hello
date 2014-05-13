require 'spec_helper'

describe "classic" do
describe "registration" do


  it "sign up" do
    #
    # SUCCESS
    #
    expect(User.count).to     eq(0)
    expect(Credential.count).to eq(0)

    when_sign_up_with_standard_data
        expect(page).to have_content "Welcome! Welcome from Sign Up"
        expect(User.count).to     eq(1)
        expect(Credential.count).to eq(1)
        expect(current_path).to eq hello.classic_after_sign_up_path

    then_I_should_be_logged_in

    when_I_sign_out

    # pending "works with json"
    # pending "sends confirmation email"
    # pending "sends welcome email"


    #
    # ERROR
    #
    when_sign_up_with_standard_data
        expect(page).to have_content "found when signing up"
        expect(User.count).to     eq(1)
        expect(Credential.count).to eq(1)


    then_I_should_be_logged_out


    # pending "works with json"
    puts "should work with json"
  end

  it "sign in" do
    when_sign_up_with_standard_data
    when_I_sign_out
    then_I_should_be_logged_out
    
    #
    # ERROR
    #
    when_sign_in_with_standard_data(password: 'wrong')
        expect(page).to have_content "found when signing in"
    then_I_should_be_logged_out
    # pending "works with json"

    #
    # SUCCESS
    #
    when_sign_in_with_standard_data
        expect(page).to have_content "Welcome! Welcome from Sign In"
        expect(current_path).to eq hello.classic_after_sign_in_path
    then_I_should_be_logged_in
    # pending "works with json"
    # pending "remember me"

    #
    # Sign Out
    #
    click_link("Sign Out")
        expect(page).to have_content "You have signed out!"
    then_I_should_be_logged_out

  end

  it "forgot" do
    #
    # ERROR
    #
    when_I_ask_to_reset_my_password('wrong')
    expect(page).to have_content "found when locating your credentials"
    then_I_should_be_logged_out
    # pending "works with json"


    #
    # SUCCESS
    #
    given_I_have_a_password_credential


    # Hello::PasswordMailer.should_receive(:forgot)    
    # open_last_email Mail::Message
    when_I_ask_to_reset_my_password
        expect(open_last_email.to_s).to have_content "/hello/classic/reset/token/"
        expect(page).to have_content "Welcome from Forgot"
        expect(current_path).to eq hello.classic_after_forgot_path
    then_I_should_be_logged_out
  end

  it "reset" do
    #
    # BAD TOKEN
    #
    visit hello.classic_reset_token_path('wrong')
        expect(current_path).to eq hello.classic_forgot_path
        expect(page).to have_content "This link has expired, please ask for a new link"

    reset_token = given_I_have_a_password_credential_and_forgot_my_password

    #
    # GOOD TOKEN, EMPTY PASSWORD
    #
    visit hello.classic_reset_token_path(reset_token)
        expect(current_path).to eq hello.classic_reset_path
    when_I_update_a_reset_password_form_with('')
        expect(page).to have_content "found when resetting your password"
    then_I_should_be_logged_out

    #
    # GOOD TOKEN, BAD PASSWORD
    #
    visit hello.classic_reset_token_path(reset_token)
        expect(current_path).to eq hello.classic_reset_path
    when_I_update_a_reset_password_form_with('1')
        expect(page).to have_content "found when resetting your password"
    then_I_should_be_logged_out

    #
    # GOOD TOKEN, GOOD PASSWORD
    #
    when_I_update_a_reset_password_form_with('the-new-password')
        expect(page).to have_content "Your password has been updated!"
        expect(current_path).to eq hello.classic_after_reset_path
    then_I_should_be_logged_in
    when_I_sign_out

    #
    # TOKEN MUST GO BAD
    #
    visit hello.classic_reset_token_path(reset_token)
        expect(page).to have_content "This link has expired, please ask for a new link"
        expect(current_path).to eq hello.classic_forgot_path

    #
    # NEW PASSWORD MUST BE GOOD NOW
    #
    when_sign_in_with_standard_data(password: 'the-new-password')
        expect(page).to have_content "Welcome! Welcome from Sign In"
        expect(current_path).to eq hello.classic_after_sign_in_path
    then_I_should_be_logged_in

  end

  it "don't keep me signed in" do
    when_sign_up_with_standard_data
    when_I_sign_out
    then_I_should_be_logged_out
    when_sign_in_with_standard_data
        expect(Session.last.expires_at).to be > 29.minutes.from_now

    #
    # 25 minutes to expire, doesn't renew expiracy
    #
    Session.last.update_attribute :expires_at, 25.minutes.from_now
    visit root_path
        then_I_should_be_logged_in
        expect(Session.last.expires_at).to be < 26.minutes.from_now
    
    #
    # 19 minutes to expire, renews expiracy to 30 minutes
    #
    Session.last.update_attribute :expires_at, 19.minutes.from_now
    visit root_path
        then_I_should_be_logged_in
        expect(Session.last.expires_at).to be > 29.minutes.from_now
    
    #
    # 1 second after expire, expires your session
    #
    Session.last.update_attribute :expires_at, 1.seconds.ago
    visit root_path
        then_I_should_be_logged_out
  end

  it "keep me signed in" do
    when_sign_up_with_standard_data
    when_I_sign_out
    then_I_should_be_logged_out
    when_sign_in_with_standard_data(keep_me: true)
        expect(Session.last.expires_at).to be > 29.days.from_now

    #
    # 20 days later, doesn't renew expiracy
    #
    Session.last.update_attribute :expires_at, 10.days.from_now
    visit root_path
        then_I_should_be_logged_in
        expect(Session.last.expires_at).to be < 11.days.from_now
    
    #
    # 19 minutes to expire, renews expiracy to 30 minutes
    #
    Session.last.update_attribute :expires_at, 19.minutes.from_now
    visit root_path
        then_I_should_be_logged_in
        expect(Session.last.expires_at).to be > 29.minutes.from_now
    
    #
    # 1 second after expire, expires your session
    #
    Session.last.update_attribute :expires_at, 1.seconds.ago
    visit root_path
        then_I_should_be_logged_out
  end

end
end