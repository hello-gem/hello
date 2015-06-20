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

    def _then_redirect_to_novice
      Then "I should be taken to novice" do
        expect(current_path).to eq '/novice'
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



      sscenario "As a Novice" do
        given_I_have_signed_in_as_a_novice
        _when_I_visit
        _then_redirect_to_novice
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_redirect_to_root
      end



      sscenario "As a Master" do
        given_I_have_signed_in_as_a_master
        _when_I_visit
        _then_redirect_to_root
      end
    end



    sstory "Novice Area" do

      def _when_I_visit
        When "I visit the Novice Area" do
          visit '/my_areas/novice_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_redirect_to_sign_in
      end


      sscenario "As a Novice" do
        given_I_have_signed_in_as_a_novice
        _when_I_visit
        _then_allowed
      end


      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_redirect_to_root
      end


      sscenario "As a Master" do
        given_I_have_signed_in_as_a_master
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



      sscenario "As a Novice" do
        given_I_have_signed_in_as_a_novice
        _when_I_visit
        _then_allowed
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_allowed
      end



      sscenario "As a Master" do
        given_I_have_signed_in_as_a_master
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



      sscenario "As a Novice" do
        given_I_have_signed_in_as_a_novice
        _when_I_visit
        _then_redirect_to_novice
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_allowed
      end



      sscenario "As a Master" do
        given_I_have_signed_in_as_a_master
        _when_I_visit
        _then_allowed
      end
    end



    sstory "Master Area" do
      def _when_I_visit
        When "I visit the Master Area" do
          visit '/my_areas/master_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_redirect_to_sign_in
      end



      sscenario "As a Novice" do
        given_I_have_signed_in_as_a_novice
        _when_I_visit
        _then_redirect_to_novice
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_redirect_to_root
      end



      sscenario "As a Master" do
        given_I_have_signed_in_as_a_master
        _when_I_visit
        _then_allowed
      end
    end



    sstory "Non Master Area" do
      def _when_I_visit
        When "I visit the Non Master Area" do
          visit '/my_areas/non_master_page'
        end
      end



      sscenario "As a Guest" do
        given_I_have_not_signed_in
        _when_I_visit
        _then_allowed
      end



      sscenario "As a Novice" do
        given_I_have_signed_in_as_a_novice
        _when_I_visit
        _then_allowed
      end



      sscenario "As a User" do
        given_I_have_signed_in_as_a_user
        _when_I_visit
        _then_allowed
      end



      sscenario "As a Master" do
        given_I_have_signed_in_as_a_master
        _when_I_visit
        _then_redirect_to_root
      end
    end








  end
end
