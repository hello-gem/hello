require "spec_helper"

module Hello

  describe DeactivationController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #index" do
        expect(get("/deactivation")).to route_to("hello/deactivation#index")
      end

          it "routes to #deactivate" do
            expect(post("/deactivation")).to route_to("hello/deactivation#deactivate")
          end

    end
  end
end
