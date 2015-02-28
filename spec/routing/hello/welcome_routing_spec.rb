require "spec_helper"

module Hello
  describe WelcomeController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #index" do
        expect(get("/")).to route_to("hello/welcome#index")
      end

    end
  end
end