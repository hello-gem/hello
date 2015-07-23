require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Internationalization", "Anyone Can Change Their Locale", "On The Profile Page" do

    # ACCEPTANCE CRITERIA
    # - 

    sstory "As a User" do
      sscenario "Success" do
        given_I_have_signed_in

        _then_the_database_locale_should_be('en')



        _when_I_update_my_locale_to('Portuguese (Brazil)')

        Then "I expect to a confirmation message in 'pt-BR'" do
          expect_flash_notice "Você atualizou seu perfil com sucesso"
        end

        _then_the_browser_locale_should_be('pt-BR')

        _then_the_database_locale_should_be('pt-BR')



        _when_I_update_my_locale_to('Spanish')

        Then "I expect to a confirmation message in 'es'" do
          expect_flash_notice "Has actualizado tu perfil satisfactoriamente"
        end

        _then_the_browser_locale_should_be('es')

        _then_the_database_locale_should_be('es')
      end
    end



    def _when_I_update_my_locale_to(string)
      When "I update my locale to '#{string}'" do
        visit hello.current_user_path

        within("form") do
          find("#user_locale").select(string)
          click_button "Update"
        end
      end
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
