require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Forgot Password" do

  it "Success - Email Sent" do
    given_I_have_a_classic_credential

    when_I_ask_to_reset_my_password

    expect_to_see "To get back into your account, follow the instructions we've sent to your \"foobar\" email address."
    # expect(open_last_email.to_s).to have_content "/hello/classic/reset/token/"
    expect(current_path).to eq hello.after_forgot_path
    then_I_should_be_logged_out
  end

  it "Error - Not Found" do
    when_I_ask_to_reset_my_password('wrong')

    expect_error_message "1 error was found while locating your credentials"
    expect(current_path).to eq hello.forgot_password_path
    then_I_should_be_logged_out
  end

end
end
end