require "spec_helper"

module Hello
  describe LocaleController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #index" do
        get("/locale").should route_to("hello/locale#index")
      end

      it "routes to #update" do
        post("/locale").should route_to("hello/locale#update")
      end
      
    end
  end
end
