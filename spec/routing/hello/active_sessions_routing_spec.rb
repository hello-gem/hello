require "spec_helper"

module Hello
  describe ActiveSessionsController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #index" do
        expect(:get => "/active_sessions").to route_to("hello/active_sessions#index")
      end

          it "routes to #destroy" do
            expect(:delete => "/active_sessions/1").to route_to("hello/active_sessions#destroy", :id => "1")
          end

    end
  end
end
