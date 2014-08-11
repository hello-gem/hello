require "spec_helper"

module Hello
  describe SignOutController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #sign_out" do
        get("/sign_out").should    route_to("hello/sign_out#sign_out")
        head("/sign_out").should   route_to("hello/sign_out#sign_out")
        post("/sign_out").should   route_to("hello/sign_out#sign_out")
        put("/sign_out").should    route_to("hello/sign_out#sign_out")
        delete("/sign_out").should route_to("hello/sign_out#sign_out")
      end
      
    end
  end
end