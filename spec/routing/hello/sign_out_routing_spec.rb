require "spec_helper"

module Hello
  describe SignOutController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #sign_out" do
        expect(get("/sign_out")).to    route_to("hello/sign_out#sign_out")
        expect(head("/sign_out")).to   route_to("hello/sign_out#sign_out")
        expect(post("/sign_out")).to   route_to("hello/sign_out#sign_out")
        expect(put("/sign_out")).to    route_to("hello/sign_out#sign_out")
        expect(delete("/sign_out")).to route_to("hello/sign_out#sign_out")
      end
      
    end
  end
end