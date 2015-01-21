require "spec_helper"

module Hello
module Classic

  describe RegistrationController do
    describe "routing" do
      routes { Hello::Engine.routes }



      it "routes to #index" do
        get("/sign_up").should route_to("hello/classic_registration/sign_up#index")
      end

          it "routes to #create" do
            post("/sign_up").should route_to("hello/classic_registration/sign_up#create")
          end




      it "routes to #index" do
        get("/sign_in").should route_to("hello/classic_registration/sign_in#index")
      end

          it "routes to #authenticate" do
            post("/sign_in").should route_to("hello/classic_registration/sign_in#authenticate")
          end

              it "routes to #authenticated" do
                get("/authenticated").should route_to("hello/classic_registration/sign_in#authenticated")
              end





      it "routes to #index" do
        get("/password/forgot").should route_to("hello/classic_registration/forgot_password#index")
      end

          it "routes to #remember" do
            post("/password/forgot").should route_to("hello/classic_registration/forgot_password#remember")
          end

              it "routes to #remembered" do
                get("/password/remembered").should route_to("hello/classic_registration/forgot_password#remembered")
              end




      it "routes to #reset_token" do
        get("/password/reset/123").should route_to("hello/classic_registration/reset_password#reset_token", token: '123')
      end

          it "routes to #index" do
            get("/password/reset").should route_to("hello/classic_registration/reset_password#index")
          end

              it "routes to #save" do
                post("/password/reset").should route_to("hello/classic_registration/reset_password#save")
              end

                  it "routes to #done" do
                    get("/password/reset/done").should route_to("hello/classic_registration/reset_password#done")
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
