require 'spec_helper'

describe "classic" do


  it "sudo mode" do
    when_sign_up_with_standard_data

    click_link "Settings"
    click_link "Devices"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.sessions_path
        expect(Session.last.sudo_expires_at).to be < Time.now

    #
    # BLANK
    #
    when_I_confirm_my_credential_password('')
        expect(page).to have_content "Incorrect Password"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.sudo_mode_path
        expect(Session.last.sudo_expires_at).to be < Time.now

    #
    # ERROR
    #
    when_I_confirm_my_credential_password('wrong')
        expect(page).to have_content "Incorrect Password"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.sudo_mode_path
        expect(Session.last.sudo_expires_at).to be < Time.now

    #
    # SUCCESS
    #
    when_I_confirm_my_credential_password
        expect(page).to have_content "Now we know it's really you"
        expect(page).not_to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.sessions_path
        expect(Session.last.sudo_expires_at).to be > 29.minutes.from_now

  end

end
