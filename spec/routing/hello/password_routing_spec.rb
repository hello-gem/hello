require "spec_helper"

module Hello
  describe PasswordController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #edit" do
        expect(get("/password")).to route_to("hello/password#edit")
      end

          it "routes to #update" do
            expect(patch("/password")).to route_to("hello/password#update")
          end

      
    end
  end
end
