require 'spec_helper'

describe "Change Locale" do


  # As a Guest
  # I can choose a new locale
  # So I can see the website in a new locale
  it "Guest" do
    #
    # To Portuguese
    #
    visit hello.locale_path
    click_button 'Portuguese (Brazil)'
    expect_flash_notice "Your current language has been applied successfully. 'Portuguese (Brazil)'"

    #
    # To English
    #
    visit hello.locale_path
    click_button 'English'
    expect_flash_notice "Your current language has been applied successfully. 'English'"
  end


end
