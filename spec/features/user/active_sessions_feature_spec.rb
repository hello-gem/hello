require 'spec_helper'

describe "active sessions" do

  it "disconnect" do
    given_I_am_logged_in
    create(:active_session, credential: Credential.last)

    click_link "Settings"
    click_link "Active Sessions (2)"
    when_I_confirm_my_credential_password
    expect(current_path).to eq hello.active_sessions_path

    then_I_should_not_see("Active Sessions (1)")
    click_button "Unlink"
        expect_flash_notice("Device has been unlinked from your account")
        then_I_should_see("Active Sessions (1)")
  end

end
