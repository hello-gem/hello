require "spec_helper"

module Hello
  describe SignOutController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #sign_out" do
        get("/sign_out").should route_to("hello/sign_out#sign_out")
      end
      
    end
  end
end