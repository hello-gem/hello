require 'spec_helper'

RSpec.bdd.uic "On The Sign In Form" do

  # ACCEPTANCE CRITERIA
  # - My browser learns my account’s locale

  story "As a Guest" do
    scenario "Success" do
      Given "The browser's locale is set to 'English'" do
        visit '/'
        expect_to_see "dummy-locale: en"
      end

      When "I sign in to a 'pt-BR' user" do
        user = given_I_have_a_user
        user.update! locale: 'pt-BR'
        when_sign_in_with_standard_data(skip_expire: true)
      end

      Then "I expect to a confirmation message in 'en'" do
        expect_flash_notice "You have signed in successfully"
      end

      Then "the Browser's locale should be 'pt-BR'" do
        expect_to_see "dummy-locale: pt-BR"
      end
    end
  end

end
