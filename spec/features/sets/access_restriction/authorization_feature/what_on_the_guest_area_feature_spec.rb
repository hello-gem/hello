require 'spec_helper'

describe "Feature Set: Access Restriction" do
  feature_www "Authorization",
          where: "On the Guest Area" do



    what "On the Welcome page" do

      who "As a Guest" do
        scenario "Access Granted" do
          visit2 :guest, '/hello'
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_authenticated
        end
      end

      who "As a User" do
        scenario "Access Denied" do
          visit2 :user, '/hello/user', :cannot_be_a_authenticated
        end
      end

      who "As an Admin" do
        scenario "Access Denied" do
          visit2 :admin, '/hello/admin', :cannot_be_a_authenticated
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit '/hello'
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "On the Forgot Password page" do

      who "As a Guest" do
        scenario "Access Granted" do
          visit2 :guest, '/hello/password/forgot'
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_authenticated
        end
      end

      who "As a User" do
        scenario "Access Denied" do
          visit2 :user, '/hello/user', :cannot_be_a_authenticated
        end
      end

      who "As an Admin" do
        scenario "Access Denied" do
          visit2 :admin, '/hello/admin', :cannot_be_a_authenticated
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit '/hello/password/forgot'
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "On the Sign Up page" do

      who "As a Guest" do
        scenario "Access Granted" do
          visit2 :guest, '/hello/sign_up'
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_authenticated
        end
      end

      who "As a User" do
        scenario "Access Denied" do
          visit2 :user, '/hello/user', :cannot_be_a_authenticated
        end
      end

      who "As an Admin" do
        scenario "Access Denied" do
          visit2 :admin, '/hello/admin', :cannot_be_a_authenticated
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit '/hello/sign_up'
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end

    

    what "On the Sign In page" do

      who "As a Guest" do
        scenario "Access Granted" do
          visit2 :guest, '/hello/sign_in'
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :cannot_be_a_authenticated
        end
      end

      who "As a User" do
        scenario "Access Denied" do
          visit2 :user, '/hello/user', :cannot_be_a_authenticated
        end
      end

      who "As an Admin" do
        scenario "Access Denied" do
          visit2 :admin, '/hello/admin', :cannot_be_a_authenticated
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit '/hello/sign_in'
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



  end
end