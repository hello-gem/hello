# encoding: UTF-8

require 'spec_helper'

describe "Localization" do
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
      expect_flash_notice "Your current language has been applied successfully. 'Português (Brasil)'"

      #
      # To English
      #
      visit hello.locale_path
      click_button 'English'
      expect_flash_notice "Your current language has been applied successfully. 'English'"
    end

    it "User" do
      when_sign_up_with_standard_data(expect_welcome_mailer: true)

      visit hello.locale_path
      #
      # To Portuguese
      #
      expect {
        click_button 'Portuguese (Brazil)'
        expect_flash_notice "Your current language has been applied successfully. 'Português (Brasil)'"
      }.to change { User.last.locale }.from('en').to('pt-BR')

      #
      # To English
      #
      expect {
        click_button 'English'
        expect_flash_notice "Your current language has been applied successfully. 'English'"
      }.to change { User.last.locale }.from('pt-BR').to('en')

    end

  end
end
