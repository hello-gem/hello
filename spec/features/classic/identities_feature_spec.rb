require 'spec_helper'

describe "classic" do
describe "identities" do

  it "email" do
    given_I_am_logged_in
    click_link "Edit Me"
    click_link "Edit Email"
    expect(current_path).to eq hello.email_classic_identity_path(Identity.last)

    #
    # ERROR
    #
    within("form") do
      fill_in 'identity_email',    with: 'a'
    end
    click_button 'Update'
    expect(page).to have_content "found when updating your email"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'identity_email', with: 'yakko@someemail.com'
    end
    click_button 'Update'
    expect(page).to have_content "Your identity was successfully updated."
    expect(current_path).to eq hello.user_path
    updated_identity = Identity.last
    expect(updated_identity.email).to eq 'yakko@someemail.com'

    # pending "works with json"

  end

  it "username" do
    given_I_am_logged_in
    click_link "Edit Me"
    click_link "Edit Username"
    expect(current_path).to eq hello.username_classic_identity_path(Identity.last)

    #
    # ERROR
    #
    within("form") do
      fill_in 'identity_username', with: ''
    end
    click_button 'Update'
    expect(page).to have_content "found when updating your username"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'identity_username', with: 'yakko'
    end
    click_button 'Update'
    expect(page).to have_content "Your identity was successfully updated."
    expect(current_path).to eq hello.user_path
    updated_identity = Identity.last
    expect(updated_identity.username).to eq 'yakko'

    # pending "works with json"

  end

  it "password" do
    given_I_am_logged_in
    click_link "Edit Me"
    click_link "Edit Password"
    expect(current_path).to eq hello.password_classic_identity_path(Identity.last)

    #
    # ERROR
    #
    within("form") do
      fill_in 'identity_password', with: 'a'
    end
    click_button 'Update'
    expect(page).to have_content "found when updating your password"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'identity_password', with: '123456'
    end
    click_button 'Update'
    expect(page).to have_content "Your identity was successfully updated."
    expect(current_path).to eq hello.user_path
    updated_identity = Identity.last
    expect(updated_identity.password_is? '123456').to eq true

    # pending "works with json"

  end



end
end