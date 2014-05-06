require 'spec_helper'

describe "classic" do
describe "registration" do


  it "sign up" do
    #
    # SUCCESS
    #
    expect(User.count).to     eq(0)
    expect(Identity.count).to eq(0)

    when_sign_up_with_standard_data
        expect(page).to have_content "Welcome! Welcome from Sign Up"
        expect(User.count).to     eq(1)
        expect(Identity.count).to eq(1)
        expect(current_path).to eq hello.classic_sign_up_welcome_path

    then_I_should_be_logged_out


    # pending "works with json"
    # pending "sends confirmation email"
    # pending "sends welcome email"


    #
    # ERROR
    #
    when_sign_up_with_standard_data
        expect(page).to have_content "found when signing up"
        expect(User.count).to     eq(1)
        expect(Identity.count).to eq(1)


    then_I_should_be_logged_out


    # pending "works with json"
    puts "should work with json"
  end

  it "sign in" do
    when_sign_up_with_standard_data
    then_I_should_be_logged_out
    
    #
    # ERROR
    #
    when_sign_in_with_standard_data('wrong')
        expect(page).to have_content "found when signing in"
    then_I_should_be_logged_out
    # pending "works with json"

    #
    # SUCCESS
    #
    when_sign_in_with_standard_data
        expect(page).to have_content "Welcome! Welcome from Sign In"
        expect(current_path).to eq hello.classic_sign_in_welcome_path
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
    given_I_have_a_password_identity


    # Hello::PasswordMailer.should_receive(:forgot)    
    # open_last_email Mail::Message
    when_I_ask_to_reset_my_password
        expect(open_last_email.to_s).to have_content "/hello/classic/reset/token/"
        expect(page).to have_content "Welcome from Forgot"
        expect(current_path).to eq hello.classic_forgot_welcome_path
    then_I_should_be_logged_out
  end

  it "reset" do
    #
    # BAD TOKEN
    #
    visit hello.classic_reset_token_path('wrong')
        expect(current_path).to eq hello.classic_forgot_path
        expect(page).to have_content "This link has expired, please ask for a new link"

    reset_token = given_I_have_a_password_identity_and_forgot_my_password

    #
    # GOOD TOKEN, EMPTY PASSWORD
    #
    visit hello.classic_reset_token_path(reset_token)
        expect(current_path).to eq hello.classic_reset_path
    when_I_update_a_password_form_with('')
        expect(page).to have_content "found when resetting your password"
    then_I_should_be_logged_out

    #
    # GOOD TOKEN, BAD PASSWORD
    #
    visit hello.classic_reset_token_path(reset_token)
        expect(current_path).to eq hello.classic_reset_path
    when_I_update_a_password_form_with('1')
        expect(page).to have_content "found when resetting your password"
    then_I_should_be_logged_out

    #
    # GOOD TOKEN, GOOD PASSWORD
    #
    when_I_update_a_password_form_with('the-new-password')
        expect(page).to have_content "Your password has been updated!"
        expect(current_path).to eq hello.classic_sign_in_path
    then_I_should_be_logged_out

    #
    # TOKEN MUST GO BAD
    #
    visit hello.classic_reset_token_path(reset_token)
        expect(page).to have_content "This link has expired, please ask for a new link"
        expect(current_path).to eq hello.classic_forgot_path

    #
    # NEW PASSWORD MUST BE GOOD NOW
    #
    when_sign_in_with_standard_data('the-new-password')
        expect(page).to have_content "Welcome! Welcome from Sign In"
        expect(current_path).to eq hello.classic_sign_in_welcome_path
    then_I_should_be_logged_in

  end

end
end