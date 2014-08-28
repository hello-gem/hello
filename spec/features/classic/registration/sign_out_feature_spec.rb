require 'spec_helper'

describe "Classic" do
describe "Registration" do
describe "Sign Out" do

  it "Notice" do
    given_I_am_logged_in

    click_link("Sign Out")
    
    expect_flash_notice "You have signed out!"
    then_I_should_be_logged_out
    expect(current_path).to eq hello.sign_out_path
  end

end
end
end