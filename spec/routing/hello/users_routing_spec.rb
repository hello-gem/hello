require "spec_helper"

module Hello
module Webmaster
  RSpec.describe UsersController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(:get => "/users").to route_to("users#index")
      end

      it "routes to #show" do
        expect(:get => "/users/1").to route_to("users#show", :id => "1")
      end

    end
  end
end
end
