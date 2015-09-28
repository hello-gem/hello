require 'spec_helper'

RSpec.describe "Hello Gem", type: :feature do
  goal_feature "Authentication", "Authorization", "Role Restriction" do



    def _then_allowed
      Then "I should be allowed" do
        expect_to_see "yes!"
      end
    end

    def _then_redirect_to_root
      Then "I should be taken home" do
        expect(current_path).to eq '/'
      end
    end

    def _then_redirect_to_sign_in
      Then "I should be taken to sign in" do
        expect(current_path).to eq hello.sign_in_path
      end
    end

    def _then_redirect_to_onboarding
      Then "I should be taken to onboarding" do
        expect(current_path).to eq '/onboarding'
      end
    end






    sstory "Guest Area" do
      def _when_I_visit
        When "I visit the Guest Area" do
          visit '/my_areas/guest_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_allowed
      end



      sscenario "As an Onboarding" do
        given_I_have_signed_in_as_an_onboarding
        _when_I_visit
        _then_redirect_to_onboarding
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_redirect_to_root
      end



      sscenario "As a Webmaster" do
        given_I_have_signed_in_as_a_webmaster
        _when_I_visit
        _then_redirect_to_root
      end
    end



    sstory "Onboarding Area" do

      def _when_I_visit
        When "I visit the Onboarding Area" do
          visit '/my_areas/onboarding_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_redirect_to_sign_in
      end


      sscenario "As an Onboarding" do
        given_I_have_signed_in_as_an_onboarding
        _when_I_visit
        _then_allowed
      end


      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_redirect_to_root
      end


      sscenario "As a Webmaster" do
        given_I_have_signed_in_as_a_webmaster
        _when_I_visit
        _then_redirect_to_root
      end
    end



    sstory "Authenticated Area" do
      def _when_I_visit
        When "I visit the Authenticated Area" do
          visit '/my_areas/authenticated_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_redirect_to_sign_in
      end



      sscenario "As an Onboarding" do
        given_I_have_signed_in_as_an_onboarding
        _when_I_visit
        _then_allowed
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_allowed
      end



      sscenario "As a Webmaster" do
        given_I_have_signed_in_as_a_webmaster
        _when_I_visit
        _then_allowed
      end
    end



    sstory "User Area" do
      def _when_I_visit
        When "I visit the User Area" do
          visit '/my_areas/user_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_redirect_to_sign_in
      end



      sscenario "As an Onboarding" do
        given_I_have_signed_in_as_an_onboarding
        _when_I_visit
        _then_redirect_to_onboarding
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_allowed
      end



      sscenario "As a Webmaster" do
        given_I_have_signed_in_as_a_webmaster
        _when_I_visit
        _then_allowed
      end
    end



    sstory "Webmaster Area" do
      def _when_I_visit
        When "I visit the Webmaster Area" do
          visit '/my_areas/webmaster_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_redirect_to_sign_in
      end



      sscenario "As an Onboarding" do
        given_I_have_signed_in_as_an_onboarding
        _when_I_visit
        _then_redirect_to_onboarding
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_redirect_to_root
      end



      sscenario "As a Webmaster" do
        given_I_have_signed_in_as_a_webmaster
        _when_I_visit
        _then_allowed
      end
    end



    sstory "Non Webmaster Area" do
      def _when_I_visit
        When "I visit the Non Webmaster Area" do
          visit '/my_areas/non_webmaster_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_allowed
      end



      sscenario "As an Onboarding" do
        given_I_have_signed_in_as_an_onboarding
        _when_I_visit
        _then_allowed
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_allowed
      end



      sscenario "As a Webmaster" do
        given_I_have_signed_in_as_a_webmaster
        _when_I_visit
        _then_redirect_to_root
      end
    end








  end
end
