require "spec_helper"

module Hello

  describe DeactivationController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #proposal" do
        get("/deactivation").should route_to("hello/deactivation#proposal")
      end

          it "routes to #deactivate" do
            post("/deactivation").should route_to("hello/deactivation#deactivate")
          end

              it "routes to #after_deactivate" do
                get("/after_deactivation").should route_to("hello/deactivation#after_deactivate")
              end
   
    end
  end
end
