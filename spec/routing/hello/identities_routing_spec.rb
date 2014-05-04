require "spec_helper"

module Hello
  describe IdentitiesController do
    describe "routing" do
      routes { Hello::Engine.routes }

      # it "routes to #index" do
      #   expect(:get => "/identities").to route_to("hello/identities#index")
      # end

      # it "routes to #new" do
      #   expect(:get => "/identities/new").to route_to("hello/identities#new")
      # end

      # it "routes to #create" do
      #   expect(:post => "/identities").to route_to("hello/identities#create")
      # end

      it "routes to #show" do
        expect(:get => "/identities/1").to route_to("hello/identities#show", :id => "1")
      end

      # it "routes to #edit" do
      #   expect(:get => "/identities/1/edit").to route_to("hello/identities#edit", :id => "1")
      # end

      it "routes to #update" do
        expect(:put => "/identities/1").to route_to("hello/identities#update", :id => "1")
      end

      # it "routes to #destroy" do
      #   expect(:delete => "/identities/1").to route_to("hello/identities#destroy", :id => "1")
      # end

    end
  end
end
