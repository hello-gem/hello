require "spec_helper"

module Hello
module Classic

  describe RegistrationController do
    describe "routing" do
      routes { Hello::Engine.routes }



      it "routes to #sign_up" do
        get("/sign_up").should route_to("hello/classic_registration/sign_up#index")
      end

          it "routes to #create" do
            post("/sign_up").should route_to("hello/classic_registration/sign_up#create")
          end




      it "routes to #sign_in" do
        get("/sign_in").should route_to("hello/classic_registration/sign_in#index")
      end

          it "routes to #authenticate" do
            post("/sign_in").should route_to("hello/classic_registration/sign_in#authenticate")
          end

              it "routes to #authenticated" do
                get("/authenticated").should route_to("hello/classic_registration/sign_in#authenticated")
              end





      it "routes to #forgot_password" do
        get("/password/forgot").should route_to("hello/classic_registration/forgot_password#index")
      end

          it "routes to #ask" do
            post("/password/forgot").should route_to("hello/classic_registration/forgot_password#remember")
          end

              it "routes to #after_forgot" do
                get("/password/remembered").should route_to("hello/classic_registration/forgot_password#remembered")
              end




      it "routes to #reset_token" do
        get("/reset/token/123").should route_to("hello/classic/registration#reset_token", token: '123')
      end

          it "routes to #reset_password" do
            get("/reset_password").should route_to("hello/classic/registration#reset")
          end

              it "routes to #save" do
                post("/reset_password").should route_to("hello/classic/registration#save")
              end

                  it "routes to #after_reset" do
                    get("/after_reset").should route_to("hello/classic/registration#after_reset")
                  end

      

      it "routes to #confirm_email_send" do
        get("/confirm_email/send").should route_to("hello/classic/registration#confirm_email_send")
      end

      it "routes to #confirm_email_token" do
        get("/confirm_email/token/123").should route_to("hello/classic/registration#confirm_email_token", token: '123')
      end

          it "routes to #confirm_email_expired" do
            get("/confirm_email/expired").should route_to("hello/classic/registration#confirm_email_expired")
          end

          it "routes to #after_confirm_email" do
            get("/after_confirm_email").should route_to("hello/classic/registration#after_confirm_email")
          end




          
    end
  end
end
end
