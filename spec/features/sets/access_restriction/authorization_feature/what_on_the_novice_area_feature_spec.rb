require 'spec_helper'

describe "Feature Set: Access Restriction" do
  feature_www "Authorization",
          where: "On the Novice Area" do

    who "As a Guest" do
      scenario "Access Denied" do
        visit2 :guest, '/novice', '/hello/sign_in', :must_be_authenticated
      end
    end

    who "As a Novice" do
      scenario "Access Granted" do
        visit2 :novice, '/novice', '/novice'
      end
    end

    who "As a User" do
      scenario "Access Denied" do
        visit2 :user, '/novice', '/hello/user', :must_be_a_novice
      end
    end

    who "As a Master" do
      scenario "Access Denied" do
        visit2 :master, '/novice', '/hello/master', :must_be_a_novice
      end
    end

    def visit2(role, a, expected_path, expected_flash_message=nil)
      sign_up_as_a(role)
      visit a
      expect(current_path).to eq(expected_path)
      expect_flash_auth(expected_flash_message)
    end

  end
end