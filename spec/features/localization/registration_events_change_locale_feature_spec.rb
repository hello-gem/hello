require 'spec_helper'

describe "Localization" do
  describe "Registration Events" do
    
    it "Sign Up Sets Locale" do
      #
      # To Portuguese
      #
      visit hello.locale_path
      click_button 'Portuguese (Brazil)'
      expect_flash_notice "Your current language has been applied successfully. 'Português (Brasil)'"

      #
      # SUCCESS
      #
      when_sign_up_with_standard_data(expect_welcome_mailer: true)
          expect(User.last.locale).to eq('pt-BR')
          expect_flash_notice "You have signed up successfully"
    end

    it "Sign In Resets Locale" do
      given_I_have_a_classic_active_session
      User.last.update! locale: 'pt-BR'
      
      #
      # To English
      #
      visit hello.locale_path
      click_button 'English'
      expect_flash_notice "Your current language has been applied successfully. 'English'"

      #
      # SUCCESS
      #
      when_sign_in_with_standard_data
          expect_flash_notice "You have signed in successfully"
          expect(page).to have_content('locale: pt-BR')
    end

  end
end
