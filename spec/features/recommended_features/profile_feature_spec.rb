require 'spec_helper'

describe "Profile" do


  it "works" do
    credential = given_I_have_a_classic_credential

    # visit profile_path(credential.username)
    visit profile_path('foobar')


    then_I_should_be_logged_out
    expect(page).to have_selector "h1", text: "James Pinto"
    expect(page).to have_selector "p", text: "role: user"
  end


end
