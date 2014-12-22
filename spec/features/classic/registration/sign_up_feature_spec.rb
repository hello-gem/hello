require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Sign Up" do

  it "Success" do
    when_sign_up_as_a_novice(expect_welcome_mailer: true)


    expect_flash_notice "You have signed up successfully"
    # expect(current_path).to eq hello.after_sign_up_path
    expect(current_path).to eq '/novice'
    then_I_should_be_logged_in
  end

  it "Error - Blank fields show validation errors" do
    given_I_have_a_classic_active_session
    
    when_sign_up_as_a_novice(expect_welcome_mailer: false, expect_success: false)

    expect_error_message "2 errors were found while trying to sign up"
    expect_to_see "This email address has already been registered."
    expect_to_see "This username has already been registered."
    expect(current_path).to eq hello.sign_up_path
    then_I_should_be_logged_out
  end

end
end
end