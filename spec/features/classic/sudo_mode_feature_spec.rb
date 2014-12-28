require 'spec_helper'

describe "Classic" do
describe "Sudo Mode" do

  def visit_restricted_area
    when_sign_up_with_standard_data(expect_welcome_mailer: true)

    click_link "Settings"
    click_link "Access Tokens"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.access_tokens_path
        expect(AccessToken.last.sudo_expires_at).to be < Time.now
  end

  describe "Authenticate" do
    
    before { visit_restricted_area }

    describe "Error" do
      it "Blank" do
        when_I_confirm_my_credential_password('')
      end
      it "Wrong" do
        when_I_confirm_my_credential_password('wrong')
      end

      after do
        expect_flash_alert "Incorrect Password"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.sudo_mode_path
        expect(AccessToken.last.sudo_expires_at).to be < Time.now
      end
    end

    it "Success" do
      when_I_confirm_my_credential_password

      expect_flash_notice "Now we know it's really you. We won't be asking your password again for 60 minutes"
      expect(page).to have_content "Sudo Mode expires in"
      expect(page).not_to have_content "Confirm Password to Continue"
      expect(current_path).to eq hello.access_tokens_path
      expect(AccessToken.last.sudo_expires_at).to be > 29.minutes.from_now
    end
  end

  describe "Expire" do
    it "Success" do
      visit_restricted_area
      when_I_confirm_my_credential_password

      click_link "expire"

      expect_flash_notice "We will now ask your password for sensitive access"
      expect(page).not_to have_content "Sudo Mode expires in"
      expect(current_path).to eq hello.user_path
    end

    it "Failure" do
      pending "provide scenario on how a Sudo Expiration can go wrong"
    end
  end

end
end
