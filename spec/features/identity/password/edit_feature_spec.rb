require 'spec_helper'

describe "identity" do
describe "edit" do

  it "success and error" do
    given_I_am_logged_in
    click_link "Edit Me"
    click_link "Edit Email"
    expect(current_path).to eq hello.identity_path(Identity.last)

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'identity_email',    with: 'a'
      fill_in 'identity_username', with: 'b'
      # fill_in 'password', with: 'foobar'
    end
    click_button 'Save'
    expect(page).to have_content "found when updating your account"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'identity_email',    with: 'yakko@someemail.com'
      fill_in 'identity_username', with: 'yakko'
      # fill_in 'password', with: 'foobar'
    end
    click_button 'Save'
    expect(page).to have_content "Your identity was successfully updated."
    expect(page).to have_content "Hello, James Pinto!"
    expect(current_path).to eq hello.identity_path(Identity.last)
    updated_identity = Identity.last
    expect(updated_identity.email).to eq    'yakko@someemail.com'
    expect(updated_identity.username).to eq 'yakko'

    # pending "works with json"

  end



end
end