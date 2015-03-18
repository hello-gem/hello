require 'spec_helper'

describe "access tokens" do

  describe "disconnect" do
    it "Success" do
      given_I_am_logged_in
      create(:access_token, user: User.last)

      click_link "Settings"
      click_link "Access Tokens (2)"
      when_I_confirm_my_user_password

      expect(current_path).to eq hello.access_tokens_path
      then_I_should_not_see("Access Tokens (1)")
      click_button "Unlink"
      expect_flash_notice("Device has been unlinked from your account")
      then_I_should_see("Access Tokens (1)")
    end

    it "Alert" do
      skip "DestroyAccessTokenEntity#alert_message"
    end
  end

end
