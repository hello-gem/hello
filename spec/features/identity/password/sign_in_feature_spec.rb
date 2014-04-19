require 'spec_helper'

describe "identity" do
describe "password" do

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
        expect(current_path).to eq hello.password_sign_in_welcome_path
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



end
end