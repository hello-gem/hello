require 'spec_helper'

describe "identity" do
describe "password" do


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
        expect(current_path).to eq hello.password_sign_up_welcome_path

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


end
end