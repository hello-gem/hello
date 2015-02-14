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

              it "routes to #done" do
                get("/deactivation/done").should route_to("hello/deactivation#done")
              end
   
    end
  end
end
