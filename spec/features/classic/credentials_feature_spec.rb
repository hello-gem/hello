require 'spec_helper'

describe "classic" do
describe "credentials" do

  before do
    given_I_am_logged_in
    click_link "Settings"
    click_link "Access Tokens"
    when_I_confirm_my_credential_password
    expect(current_path).to eq hello.access_tokens_path
  end

  describe "Email" do
    before { click_link "Email" }

    it "Error" do
      fill_in 'credential_email', with: 'a'
      click_button 'Update'

      expect_flash_alert "1 error was found while updating your email"
    end
    
    it "Success" do
      fill_in 'credential_email', with: 'thejamespinto@someemail.com'
      click_button 'Update'

      expect_flash_notice "Your email was successfully updated"
      expect(current_path).to eq hello.user_path
      updated_credential = Credential.last
      expect(updated_credential.email).to eq 'thejamespinto@someemail.com'
    end    

  end

  describe "Username" do
    before { click_link "Username" }

    it "Error" do
      fill_in 'credential_username', with: 'a'
      click_button 'Update'

      expect_flash_alert "1 error was found while updating your username"
    end
    
    it "Success" do
      fill_in 'credential_username', with: 'thejamespinto'
      click_button 'Update'

      expect_flash_notice "Your username was successfully updated"
      expect(current_path).to eq hello.user_path
      updated_credential = Credential.last
      expect(updated_credential.username).to eq 'thejamespinto'
    end    

  end

  describe "Password" do
    before { click_link "Password" }

    it "Error" do
      fill_in 'credential_password', with: 'a'
      click_button 'Update'

      expect_flash_alert "1 error was found while updating your password"
    end
    
    it "Success" do
      fill_in 'credential_password', with: '123456'
      click_button 'Update'

      expect_flash_notice "Your password was successfully updated"
      expect(current_path).to eq hello.user_path
      updated_credential = Credential.last
      expect(updated_credential.password_is? '123456').to eq true
    end    

  end

end
end