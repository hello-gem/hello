require 'spec_helper'

RSpec.bdd.uic "Profile Page" do



  def self._before__given_I_am_on_the_profile_page
    before do
      Given "I am on the Profile Management Page" do
        given_I_have_signed_in
        click_link "Settings"
        expect(current_path).to eq hello.current_user_path
      end
    end
  end



  story "Update Fields" do
    _before__given_I_am_on_the_profile_page



    scenario "Valid" do
      When "I submit new valid values in the form" do
        fill_in 'user_name',     with: (@new_name     = 'James Pinto')
        fill_in 'user_city',     with: (@new_city     = 'Brasilia')
        fill_in 'user_username', with: (@new_username = 'new_username')
        click_button 'Update'
      end



      Then "I should see a confirmation message" do
        expect_flash_notice "You have updated your profile successfully"
      end



      Then "and the new values should reflect on the database" do
        user = User.last
        expect(user.name).to eq(@new_name)
        expect(user.city).to eq(@new_city)
        expect(user.username).to eq(@new_username)
      end
    end



    scenario "Invalid" do
      When "I submit new invalid values in the form" do
        fill_in 'user_name', with: ''
        click_button 'Update'
      end



      Then "I should see an alert message" do
        expect_error_message "1 error was found while updating your profile"
      end
    end
  end


end
