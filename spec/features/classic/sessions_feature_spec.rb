require 'spec_helper'

describe "sessions" do

  it "disconnect" do
    given_I_am_logged_in
    FactoryGirl.create(:session, credential: Credential.last)

    click_link "Settings"
    click_link "Devices (2)"
    when_I_confirm_my_credential_password
    expect(current_path).to eq hello.sessions_path

    expect(page).not_to have_content "Devices (1)"
    click_link "Disconnect this device"
    expect(page).to have_content "Devices (1)"

  end


end
