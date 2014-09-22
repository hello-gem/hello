require 'spec_helper'

describe "user" do
describe "edit" do

  before do
    given_I_am_logged_in
    click_link "Settings"
    expect(current_path).to eq hello.user_path
  end

  it "success and error" do
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

  it "Success - Time Zone" do
    expect(find("span.current_time").text).to include('UTC')

    select('Brasilia', :from => 'Time zone')
    click_button 'Update'
    expect_flash_notice "You have updated your profile successfully"

    expect(find("span.current_time").text).not_to include('UTC')
  end


end
end