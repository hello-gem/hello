require 'spec_helper'

describe "identity" do
describe "password" do

  it "reset" do
    #
    # BAD TOKEN
    #
    visit hello.password_reset_token_path('wrong')
        expect(current_path).to eq hello.password_forgot_path
        expect(page).to have_content "This link has expired, please ask for a new link"

    #
    # GOOD TOKEN, BAD PASSWORD
    #
    reset_token = given_I_have_a_password_identity_and_forgot_my_password
    visit hello.password_reset_token_path(reset_token)
        expect(current_path).to eq hello.password_reset_path
    when_I_update_a_password_form_with('1')
        expect(page).to have_content "found when resetting your password"
    then_I_should_not_be_logged_in

    #
    # GOOD TOKEN, GOOD PASSWORD
    #
    when_I_update_a_password_form_with('the-new-password')
        expect(page).to have_content "Your password has been updated!"
        expect(current_path).to eq hello.password_sign_in_path


    then_I_should_not_be_logged_in
    expect(Hello::Session.count).to eq(0)

    #
    # TOKEN MUST GO BAD
    #
    visit hello.password_reset_token_path(reset_token)
        expect(page).to have_content "This link has expired, please ask for a new link"
        expect(current_path).to eq hello.password_forgot_path

    #
    # NEW PASSWORD MUST BE GOOD NOW
    #
    when_sign_in_with_standard_data('the-new-password')
        expect(page).to have_content "Welcome! Welcome from Sign In"
        expect(Hello::Session.count).to eq(1)
        expect(current_path).to eq hello.password_sign_in_welcome_path
    then_I_should_be_logged_in

  end





end
end