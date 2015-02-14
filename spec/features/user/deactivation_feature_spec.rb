require 'spec_helper'

describe "Deactivate" do
  before { given_I_am_logged_in }

  it "Success" do
    visit hello.deactivation_path
    click_button "Deactivate my Account"

    expect(User.count).to          eq(0)
    expect(Credential.count).to    eq(0)
    expect(AccessToken.count).to eq(0)

    then_I_should_be_logged_out
    expect(current_path).to eq hello.deactivation_done_path
    expect_flash_notice "You have deactivated your account successfully"
  end

  it "Alert" do
    User.last.addresses.create! text: "foo"
    Credential.last.some_credential_data.create! text: "foo"
    
    visit hello.deactivation_path
    click_button "Deactivate my Account"

    expect(User.count).to          eq(1)
    expect(Credential.count).to    eq(1)
    expect(AccessToken.count).to eq(1)

    then_I_should_be_logged_in
    expect(current_path).to eq hello.deactivation_path
    expect_flash_alert "Terminating your account would cause other users to experience errors while using our website. Please contact any of our staff members and ask to have your account removed manually."
  end

end