require 'spec_helper'

RSpec.bdd.uic "On The Sign Up Form" do

  # ACCEPTANCE CRITERIA
  # - My account learns my browser’s locale

  story "As a Guest" do
    scenario "Success" do
      Given "I set the browser's locale to 'Portuguese (Brazil)'" do
        visit hello.locale_path
        click_button 'Portuguese (Brazil)'
        expect_flash_notice "Seu idioma foi atualizado com sucesso. 'Português (Brasil)'"
      end

      When "I sign up" do
        when_sign_up_as_an_onboarding(skip_expire: true, expect_welcome_mailer: true)
      end

      Then "I expect to a confirmation message in 'pt-BR'" do
        expect_flash_notice "Você se cadastrou com sucesso"
      end

      Then "the Browser's locale should be 'pt-BR'" do
        expect_to_see "dummy-locale: pt-BR"
      end

      Then "the Database's locale should be 'pt-BR'" do
        expect(User.last.locale).to eq('pt-BR')
      end
    end
  end

end
