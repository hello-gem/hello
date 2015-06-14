require 'spec_helper'

describe "Feature Set: Access Restriction" do
  feature_www "Authorization",
          where: "On the Admin Area" do



    what "On the Admin page" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :must_be_a_master
        end
      end

      who "As a User" do
        scenario "Access Denied" do
          visit2 :user, '/hello/user', :must_be_a_master
        end
      end

      who "As a Master" do
        scenario "Access Granted" do
          visit2 :master, '/hello/master'
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit '/hello/master'
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "Impersonation - Impersonate" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit '/' # <-- workaround
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Denied" do
          visit2 :novice, '/novice', :must_be_a_master
        end
      end

      who "As a User" do
        scenario "Access Denied" do
          visit2 :user, '/hello/user', :must_be_a_master
        end
      end

      who "As a Master" do
        scenario "Access Granted" do
          expect {
            visit2 :master, '/hello/user'
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        page.driver.post("/hello/master/impersonate")
        click_link('redirected')
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end



    what "Impersonation - Back to Self" do

      who "As a Guest" do
        scenario "Access Denied" do
          visit2 :guest, '/hello/sign_in', :must_be_authenticated
        end
      end

      who "As a Novice" do
        scenario "Access Granted" do
          visit2 :novice, '/novice'
        end
      end

      who "As a User" do
        scenario "Access Granted" do
          visit2 :user, '/hello/user'
        end
      end

      who "As a Master" do
        scenario "Access Granted" do
          visit2 :master, '/hello/master'
        end
      end

      def visit2(role, expected_path, expected_flash_alert=nil)
        sign_up_as_a(role)
        visit "/hello/master/impersonate"
        expect(current_path).to eq(expected_path)
        expect_flash_auth(expected_flash_alert)
      end

    end

    

  end
end