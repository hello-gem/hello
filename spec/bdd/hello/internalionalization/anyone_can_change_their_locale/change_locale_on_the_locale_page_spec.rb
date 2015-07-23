require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Internationalization", "Anyone Can Change Their Locale", "On The Sign In Form" do

    # ACCEPTANCE CRITERIA
    # - 

    sstory "As a Guest" do
      sscenario "Success" do
        Given "the Browser's locale is set to 'Portuguese (Brazil)'" do
          _set_the_locale_to 'Portuguese (Brazil)'
        end

        Then "I expect to a confirmation message in 'pt-BR'" do
          expect_flash_notice "Seu idioma foi atualizado com sucesso. 'Português (Brasil)'"
        end

        _then_the_browser_locale_should_be('pt-BR')



        When "I set the locale to 'English'" do
          _set_the_locale_to 'English'
        end

        Then "I expect to a confirmation message in 'en'" do
          expect_flash_notice "Your current language has been applied successfully. 'English'"
        end

        _then_the_browser_locale_should_be('en')
      end
    end



    sstory "As a User" do
      sscenario "Success" do
        given_I_have_signed_in

        _then_the_database_locale_should_be('en')



        When "the Browser's locale is set to 'Portuguese (Brazil)'" do
          _set_the_locale_to 'Portuguese (Brazil)'
        end

        Then "I expect to a confirmation message in 'pt-BR'" do
          expect_flash_notice "Seu idioma foi atualizado com sucesso. 'Português (Brasil)'"
        end

        _then_the_browser_locale_should_be('pt-BR')

        _then_the_database_locale_should_be('pt-BR')



        When "I set the locale to 'Spanish'" do
          _set_the_locale_to 'Spanish'
        end

        Then "I expect to a confirmation message in 'es'" do
          expect_flash_notice "Tu idioma ha sido configurado satisfactoriamente. 'Español'"
        end

        _then_the_browser_locale_should_be('es')

        _then_the_database_locale_should_be('es')
      end
    end



    def _set_the_locale_to(string)
      visit hello.locale_path
      click_button string
    end

    def _then_the_browser_locale_should_be(string)
      Then "the Browser's locale should be #{string}" do
        expect_to_see "dummy-locale: #{string}"
      end
    end

    def _then_the_database_locale_should_be(string)
      Then "the Database's locale should be '#{string}'" do
        expect(User.last.locale).to eq string
      end
    end
  end
end
