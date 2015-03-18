require 'spec_helper'

describe "Sign Out" do

  it "Success" do
    given_I_am_logged_in

    click_link("Sign Out")
    
    expect_flash_notice "You have signed out!"
    then_I_should_be_logged_out
    expect(current_path).to eq hello.sign_out_path
  end

end