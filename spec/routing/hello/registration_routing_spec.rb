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

              it "routes to #after_sign_up" do
                get("/classic/after_sign_up").should route_to("hello/classic/registration#after_sign_up")
              end




      it "routes to #sign_in" do
        get("/classic/sign_in").should route_to("hello/classic/registration#sign_in")
      end

          it "routes to #authenticate" do
            post("/classic/sign_in").should route_to("hello/classic/registration#authenticate")
          end

              it "routes to #after_sign_in" do
                get("/classic/after_sign_in").should route_to("hello/classic/registration#after_sign_in")
              end

      it "routes to #forgot" do
        get("/classic/forgot").should route_to("hello/classic/registration#forgot")
      end

          it "routes to #ask" do
            post("/classic/forgot").should route_to("hello/classic/registration#ask")
          end

              it "routes to #after_forgot" do
                get("/classic/after_forgot").should route_to("hello/classic/registration#after_forgot")
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

                  it "routes to #after_reset" do
                    get("/classic/after_reset").should route_to("hello/classic/registration#after_reset")
                  end


          
    end
  end
end
end
