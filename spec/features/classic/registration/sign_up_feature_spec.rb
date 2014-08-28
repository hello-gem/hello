require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Sign Up" do

  it "Notice" do
    when_sign_up_with_standard_data(expect_welcome_mailer: true)

    expect_flash_notice "You have signed up successfully"
    expect(current_path).to eq hello.classic_after_sign_up_path
    then_I_should_be_logged_in
  end

  it "Error" do
    given_I_have_a_classic_session
    
    when_sign_up_with_standard_data(expect_welcome_mailer: false)

    expect_error_message "2 errors were found while trying to sign up"
    expect(current_path).to eq hello.classic_sign_up_path
    then_I_should_be_logged_out
  end

end
end
end