require "spec_helper"

module Hello
  describe AccessTokensController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #index" do
        expect(:get => "/access_tokens").to route_to("hello/access_tokens#index")
      end

          it "routes to #destroy" do
            expect(:delete => "/access_tokens/1").to route_to("hello/access_tokens#destroy", :id => "1")
          end

    end
  end
end
