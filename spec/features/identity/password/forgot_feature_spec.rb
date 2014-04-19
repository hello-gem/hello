require 'spec_helper'

describe "identity" do
describe "password" do

  it "forgot" do
    #
    # ERROR
    #
    when_I_ask_to_reset_my_password('wrong')
    expect(page).to have_content "found when locating your credentials"
    expect(Hello::Session.count).to eq(0)
    then_I_should_not_be_logged_in
    # pending "works with json"


    #
    # SUCCESS
    #
    given_I_have_a_password_identity
    expect(Hello::Session.count).to eq(0)


    # Hello::PasswordMailer.should_receive(:forgot)    
    when_I_ask_to_reset_my_password

    # open_last_email Mail::Message

    expect(open_last_email.to_s).to have_content "/hello/password/reset/token/"

    expect(page).to have_content "Welcome from Forgot"
    expect(Hello::Session.count).to eq(0)
    expect(current_path).to eq hello.password_forgot_welcome_path
    then_I_should_not_be_logged_in
  end





end
end