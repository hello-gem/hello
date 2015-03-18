require 'spec_helper'

describe "Emails" do

  before do
    given_I_am_logged_in
    click_link "Settings"
    click_link "Access Tokens"
    when_I_confirm_my_user_password
    expect(current_path).to eq hello.access_tokens_path
    click_link "Email"
  end

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