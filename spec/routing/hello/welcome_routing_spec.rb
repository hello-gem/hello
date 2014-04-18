require "spec_helper"

module Hello
  describe WelcomeController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #index" do
        get("/").should route_to("hello/welcome#index")
      end

      it "routes to #sign_out" do
        get("/sign_out").should route_to("hello/welcome#sign_out")
      end
      
    end
  end
end