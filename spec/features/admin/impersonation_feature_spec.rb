require 'spec_helper'

# As an admin
# I can click "impersonate" on a user's profile
# So I can impersonate that user
describe "Admin" do
  describe "Impersonation" do

    def impersonate
      credential = given_I_have_a_classic_credential
      given_I_have_an_admin_password_credential
      when_sign_in_with_admin_data
      then_I_should_be_logged_in_as_an_admin

      # visit profile_path(credential.username)
      visit profile_path('foobar')
      click_button 'Impersonate'
      expect_flash_notice "You are now #{credential.user.name}"
      then_I_should_be_logged_in_as_a_user(2)
    end

    it "Success" do
      impersonate
    end

    it "Comes with Sudo Mode" do
      impersonate

      visit "/hello/access_tokens"
      expect(page).not_to have_button "Confirm Password"
    end

    it "Back to self" do
      impersonate
      
      click_link 'Back to Myself'
      expect_flash_notice "You are yourself again"
      then_I_should_be_logged_in_as_an_admin
    end

    it "failure" do
      skip "provide scenario on how an impersonation can go wrong"
    end

  end
end
