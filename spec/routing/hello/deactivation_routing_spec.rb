require "spec_helper"

module Hello

  describe DeactivationController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #proposal" do
        expect(get("/deactivation")).to route_to("hello/deactivation#proposal")
      end

          it "routes to #deactivate" do
            expect(post("/deactivation")).to route_to("hello/deactivation#deactivate")
          end

              it "routes to #deactivated" do
                expect(get("/deactivated")).to route_to("hello/deactivation#deactivated")
              end
   
    end
  end
end
