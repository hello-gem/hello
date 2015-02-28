require "spec_helper"

module Hello
  describe UserController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #edit" do
        expect(get("/user")).to route_to("hello/user#edit")
      end

          it "routes to #update" do
            expect(patch("/user")).to route_to("hello/user#update")
          end

      
    end
  end
end
