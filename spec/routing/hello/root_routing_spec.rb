require "spec_helper"

module Hello
  describe RootController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #index" do
        expect(get("/")).to route_to("hello/root#index")
      end

    end
  end
end