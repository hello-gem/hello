require 'spec_helper'

describe "classic" do
describe "credentials" do

  it "email" do
    given_I_am_logged_in
    click_link "Settings"
    click_link "Email"
    expect(current_path).to eq hello.email_classic_credential_path(Credential.last)

    #
    # ERROR
    #
    within("form") do
      fill_in 'credential_email',    with: 'a'
    end
    click_button 'Update'
    expect(page).to have_content "found when updating your email"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'credential_email', with: 'yakko@someemail.com'
    end
    click_button 'Update'
    expect(page).to have_content "Your credential was successfully updated."
    expect(current_path).to eq hello.user_path
    updated_credential = Credential.last
    expect(updated_credential.email).to eq 'yakko@someemail.com'

    # pending "works with json"

  end

  it "username" do
    given_I_am_logged_in
    click_link "Settings"
    click_link "Username"
    expect(current_path).to eq hello.username_classic_credential_path(Credential.last)

    #
    # ERROR
    #
    within("form") do
      fill_in 'credential_username', with: ''
    end
    click_button 'Update'
    expect(page).to have_content "found when updating your username"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'credential_username', with: 'yakko'
    end
    click_button 'Update'
    expect(page).to have_content "Your credential was successfully updated."
    expect(current_path).to eq hello.user_path
    updated_credential = Credential.last
    expect(updated_credential.username).to eq 'yakko'

    # pending "works with json"

  end

  it "password" do
    given_I_am_logged_in
    click_link "Settings"
    click_link "Password"
    expect(current_path).to eq hello.password_classic_credential_path(Credential.last)

    #
    # ERROR
    #
    within("form") do
      fill_in 'credential_password', with: 'a'
    end
    click_button 'Update'
    expect(page).to have_content "found when updating your password"

    #
    # SUCCESS
    #
    within("form") do
      fill_in 'credential_password', with: '123456'
    end
    click_button 'Update'
    expect(page).to have_content "Your credential was successfully updated."
    expect(current_path).to eq hello.user_path
    updated_credential = Credential.last
    expect(updated_credential.password_is? '123456').to eq true

    # pending "works with json"

  end



end
end