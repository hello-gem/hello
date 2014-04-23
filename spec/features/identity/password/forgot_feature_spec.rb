require 'spec_helper'

describe "identity" do
describe "password" do

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
        expect(open_last_email.to_s).to have_content "/hello/password/reset/token/"
        expect(page).to have_content "Welcome from Forgot"
        expect(current_path).to eq hello.password_forgot_welcome_path
    then_I_should_be_logged_out
  end





end
end