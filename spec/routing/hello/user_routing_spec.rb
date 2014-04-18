require "spec_helper"

module Hello
  describe UserController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #edit" do
        get("/user").should route_to("hello/user#edit")
      end

          it "routes to #update" do
            patch("/user").should route_to("hello/user#update")
          end

      
    end
  end
end
