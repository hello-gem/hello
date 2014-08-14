require 'spec_helper'

describe "sessions" do

  it "disconnect" do
    given_I_am_logged_in
    create(:session, credential: Credential.last)

    click_link "Settings"
    click_link "Devices (2)"
    when_I_confirm_my_credential_password
    expect(current_path).to eq hello.sessions_path

    then_I_should_not_see("Devices (1)")
    click_button "Unlink"
        expect_flash_notice("Device has been unlinked from your account")
        then_I_should_see("Devices (1)")
  end

end
