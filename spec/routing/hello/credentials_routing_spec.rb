require "spec_helper"

module Hello
module Classic
  describe CredentialsController do
    describe "routing" do
      routes { Hello::Engine.routes }

      # it "routes to #index" do
      #   expect(:get => "/classic/credentials").to route_to("hello/classic/credentials#index")
      # end

      # it "routes to #new" do
      #   expect(:get => "/classic/credentials/new").to route_to("hello/classic/credentials#new")
      # end

      # it "routes to #create" do
      #   expect(:post => "/classic/credentials").to route_to("hello/classic/credentials#create")
      # end

      # it "routes to #show" do
      #   expect(:get => "/classic/credentials/1").to route_to("hello/classic/credentials#show", :id => "1")
      # end

      # it "routes to #edit" do
      #   expect(:get => "/classic/credentials/1/edit").to route_to("hello/classic/credentials#edit", :id => "1")
      # end

      it "routes to #email" do
        expect(:get => "/classic/credentials/1/email").to route_to("hello/classic/credentials#email", :id => "1")
      end

      it "routes to #username" do
        expect(:get => "/classic/credentials/1/username").to route_to("hello/classic/credentials#username", :id => "1")
      end

      it "routes to #password" do
        expect(:get => "/classic/credentials/1/password").to route_to("hello/classic/credentials#password", :id => "1")
      end

      it "routes to #update" do
        expect(:put => "/classic/credentials/1").to route_to("hello/classic/credentials#update", :id => "1")
      end

      # it "routes to #destroy" do
      #   expect(:delete => "/classic/credentials/1").to route_to("hello/classic/credentials#destroy", :id => "1")
      # end


      #
      # CONFIRM EMAIL
      #


      it "routes to #confirm" do
        get("/credentials/1/confirm").should route_to("hello/confirm_credential#confirm", id: '1')
      end

          it "routes to #deliver" do
            post("/credentials/1/confirm").should route_to("hello/confirm_credential#deliver", id: '1')
          end

      it "routes to #confirm_token" do
        get("/credentials/1/confirm/token/123").should route_to("hello/confirm_credential#confirm_token", id: '1', token: '123')
      end

          it "routes to #expired" do
            get("/credentials/1/confirm/expired").should route_to("hello/confirm_credential#expired", id: '1')
          end

          it "routes to #done" do
            get("/credentials/1/confirm/done").should route_to("hello/confirm_credential#done", id: '1')
          end



    end
  end
end
end
