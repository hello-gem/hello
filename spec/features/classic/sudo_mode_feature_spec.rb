require 'spec_helper'

describe "classic" do


  it "sudo mode" do
    when_sign_up_with_standard_data(expect_welcome_mailer: true)

    click_link "Settings"
    click_link "Active Sessions"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.active_sessions_path
        expect(ActiveSession.last.sudo_expires_at).to be < Time.now

    #
    # BLANK
    #
    when_I_confirm_my_credential_password('')
        expect_flash_alert "Incorrect Password"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.sudo_mode_path
        expect(ActiveSession.last.sudo_expires_at).to be < Time.now

    #
    # ERROR
    #
    when_I_confirm_my_credential_password('wrong')
        expect_flash_alert "Incorrect Password"
        expect(page).to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.sudo_mode_path
        expect(ActiveSession.last.sudo_expires_at).to be < Time.now

    #
    # SUCCESS
    #
    when_I_confirm_my_credential_password
        expect_flash_notice "Now we know it's really you. We won't be asking your password again for 60 minutes"
        expect(page).to have_content "Sudo Mode expires in"
        expect(page).not_to have_content "Confirm Password to Continue"
        expect(current_path).to eq hello.active_sessions_path
        expect(ActiveSession.last.sudo_expires_at).to be > 29.minutes.from_now

    #
    # EXPIRE
    #
    click_link "expire"
        expect_flash_notice "We will now ask your password for sensitive access"
        expect(page).not_to have_content "Sudo Mode expires in"
        expect(current_path).to eq hello.user_path

  end

end
