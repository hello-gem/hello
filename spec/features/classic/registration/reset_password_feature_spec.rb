require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Reset Password" do

  it "Success" do
    reset_token = given_I_have_a_classic_credential_and_forgot_my_password
    visit hello.classic_reset_token_path(reset_token)
  
    #
    # GOOD TOKEN, GOOD PASSWORD
    #
    when_I_update_a_reset_password_form_with('the-new-password')
    
    expect_flash_notice "You have reset your password successfully"
    expect(current_path).to eq hello.classic_after_reset_path
    then_I_should_be_logged_in
    
    when_I_sign_out

    #
    # TOKEN MUST BE INVALIDATED
    #
    visit hello.classic_reset_token_path(reset_token)

    expect_flash_alert "This link has expired, please ask for a new link"
    expect(current_path).to eq hello.classic_forgot_password_path

    #
    # NEW PASSWORD MUST BE GOOD NOW
    #
    when_sign_in_with_standard_data(password: 'the-new-password')

    expect_flash_notice_signed_in
    expect(current_path).to eq hello.classic_after_sign_in_path
    then_I_should_be_logged_in
  end

  describe "Error" do

    before do
      reset_token = given_I_have_a_classic_credential_and_forgot_my_password
      visit hello.classic_reset_token_path(reset_token)
      expect(current_path).to eq hello.classic_reset_password_path
    end

    it "Empty Password" do
      when_I_update_a_reset_password_form_with('')
    end

    it "Bad Password" do
      when_I_update_a_reset_password_form_with('1')
    end

    after do
      expect_error_message "1 error was found while reseting your password"
      then_I_should_be_logged_out
    end
  end

  it "Alert - Bad Token" do
    visit hello.classic_reset_token_path('wrong')

    expect(current_path).to eq hello.classic_forgot_password_path
    expect_flash_alert "This link has expired, please ask for a new link"
  end

end
end
end