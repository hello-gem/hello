require 'spec_helper'

describe "admin" do


  # As an admin
  # I can click "impersonate" on a user's profile
  # So I can impersonate that user
  it "impersonation" do
    given_I_have_a_password_credential
    given_I_have_an_admin_password_credential
    when_sign_in_with_admin_data
    then_I_should_be_logged_in_as_an_admin


    #
    # IMPERSONATES
    #
    visit user_path(User.first)
    click_button 'Impersonate'
    then_I_should_see("You are now")
    then_I_should_be_logged_in_as_a_user(2)

    #
    # BACK TO SELF
    #
    click_link 'Back to Myself'
    then_I_should_see("You are yourself again")
    then_I_should_be_logged_in_as_an_admin
  end


end
