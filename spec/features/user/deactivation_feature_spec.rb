require 'spec_helper'

describe "Deactivate" do

  it "Notice" do
    given_I_am_logged_in

    visit hello.deactivation_path
    click_button "Deactivate my Account"

    then_I_should_be_logged_out
    expect(current_path).to eq hello.after_deactivation_path
    expect_flash_notice "You have deactivated your account successfully"
    expect(User.count).to          eq(0)
    expect(Credential.count).to    eq(0)
    expect(ActiveSession.count).to eq(0)
  end

  it "Error" do
    # expect_error_message "2 errors were found while trying to sign up"
    # expect(current_path).to eq hello.deactivation_path
    # then_I_should_be_logged_in
    pending "TODO"
  end

end