require 'spec_helper'

describe "user" do
describe "edit" do

  before do
    given_I_am_logged_in
    click_link "Settings"
    expect(current_path).to eq hello.user_path
  end

  describe "Success" do
    it "Default (with custom field)" do
      new_name = 'James Pinto'
      new_city = 'Brasilia'
      new_username = 'new_username'
      new_password = 'new_password'
      fill_in 'user_name', with: new_name
      fill_in 'user_city', with: new_city
      fill_in 'user_username', with: new_username
      # fill_in 'user_password', with: new_password

      click_button 'Update'
      
      expect_flash_notice "You have updated your profile successfully"
      expect(page).to have_content "Hello, James Pinto!"
      expect(current_path).to eq hello.user_path
      user = User.last
      expect(user.name).to eq(new_name)
      expect(user.city).to eq(new_city)
      expect(user.username).to eq(new_username)
      # expect(user.password_is?(new_password)).to eq(true)
    end

    it "Success - Time Zone" do
      expect(find("span.current_time").text).to include('UTC')

      select('Brasilia', :from => 'Time zone')
      click_button 'Update'
      expect_flash_notice "You have updated your profile successfully"

      expect(find("span.current_time").text).not_to include('UTC')
    end
  end

  it "Error" do
    fill_in 'user_name', with: ''
    click_button 'Update'
    expect_error_message "1 error was found while updating your profile"
  end

end
end