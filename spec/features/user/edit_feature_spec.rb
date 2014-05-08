require 'spec_helper'

describe "user" do
describe "edit" do

  it "success and error" do
    given_I_am_logged_in
    click_link "Settings"
    expect(current_path).to eq hello.user_path

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'user_name',    with: 'Yakko'
      fill_in 'user_city',    with: 'Brasilia'
      # fill_in 'password', with: 'foobar'
    end
    click_button 'Update'
    expect(page).to have_content "Your profile was successfully updated."
    expect(page).to have_content "Hello, Yakko!"
    expect(current_path).to eq hello.user_path

    # pending "works with json"

    #
    # ERROR
    #
    within("form") do
      fill_in 'user_name',    with: ''
      # fill_in 'password', with: 'foobar'
    end
    click_button 'Update'
    expect(page).to have_content "found when updating your profile"
  end



end
end