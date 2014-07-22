require 'spec_helper'

describe "user" do
describe "edit" do

  it "success and error" do
    given_I_am_logged_in
    click_link "Settings"
        expect(current_path).to eq hello.user_path

    puts "test time_zone and language"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'user_name',    with: 'James Pinto'
      fill_in 'user_city',    with: 'Brasilia'
    end
    click_button 'Update'
        expect_flash_notice "You have updated your profile successfully"
        expect(page).to have_content "Hello, James Pinto!"
        expect(current_path).to eq hello.user_path

    # pending "works with json"

    #
    # ERROR
    #
    within("form") do
      fill_in 'user_name',    with: ''
    end
    click_button 'Update'
        expect_error_message "1 error was found while updating your profile"
  end



end
end