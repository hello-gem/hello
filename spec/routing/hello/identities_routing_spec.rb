require "spec_helper"

module Hello
module Classic
  describe IdentitiesController do
    describe "routing" do
      routes { Hello::Engine.routes }

      # it "routes to #index" do
      #   expect(:get => "/classic/identities").to route_to("hello/classic/identities#index")
      # end

      # it "routes to #new" do
      #   expect(:get => "/classic/identities/new").to route_to("hello/classic/identities#new")
      # end

      # it "routes to #create" do
      #   expect(:post => "/classic/identities").to route_to("hello/classic/identities#create")
      # end

      # it "routes to #show" do
      #   expect(:get => "/classic/identities/1").to route_to("hello/classic/identities#show", :id => "1")
      # end

      # it "routes to #edit" do
      #   expect(:get => "/classic/identities/1/edit").to route_to("hello/classic/identities#edit", :id => "1")
      # end

      it "routes to #email" do
        expect(:get => "/classic/identities/1/email").to route_to("hello/classic/identities#email", :id => "1")
      end

      it "routes to #username" do
        expect(:get => "/classic/identities/1/username").to route_to("hello/classic/identities#username", :id => "1")
      end

      it "routes to #password" do
        expect(:get => "/classic/identities/1/password").to route_to("hello/classic/identities#password", :id => "1")
      end

      it "routes to #update" do
        expect(:put => "/classic/identities/1").to route_to("hello/classic/identities#update", :id => "1")
      end

      # it "routes to #destroy" do
      #   expect(:delete => "/classic/identities/1").to route_to("hello/classic/identities#destroy", :id => "1")
      # end

    end
  end
end
end
