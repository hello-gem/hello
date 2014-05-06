require "spec_helper"

module Hello
module Classic

  describe RegistrationController do
    describe "routing" do
      routes { Hello::Engine.routes }



      it "routes to #sign_up" do
        get("/classic/sign_up").should route_to("hello/classic/registration#sign_up")
      end

          it "routes to #create" do
            post("/classic/sign_up").should route_to("hello/classic/registration#create")
          end

              it "routes to #sign_up_welcome" do
                get("/classic/sign_up/welcome").should route_to("hello/classic/registration#sign_up_welcome")
              end




      it "routes to #sign_in" do
        get("/classic/sign_in").should route_to("hello/classic/registration#sign_in")
      end

          it "routes to #authenticate" do
            post("/classic/sign_in").should route_to("hello/classic/registration#authenticate")
          end

              it "routes to #sign_in_welcome" do
                get("/classic/sign_in/welcome").should route_to("hello/classic/registration#sign_in_welcome")
              end

      it "routes to #forgot" do
        get("/classic/forgot").should route_to("hello/classic/registration#forgot")
      end

          it "routes to #ask" do
            post("/classic/forgot").should route_to("hello/classic/registration#ask")
          end

              it "routes to #forgot_welcome" do
                get("/classic/forgot/welcome").should route_to("hello/classic/registration#forgot_welcome")
              end




      it "routes to #reset_token" do
        get("/classic/reset/token/123").should route_to("hello/classic/registration#reset_token", token: '123')
      end

          it "routes to #reset" do
            get("/classic/reset").should route_to("hello/classic/registration#reset")
          end

              it "routes to #save" do
                post("/classic/reset").should route_to("hello/classic/registration#save")
              end

          
    end
  end
end
end
