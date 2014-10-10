require "spec_helper"

module Hello
module Classic

  describe RegistrationController do
    describe "routing" do
      routes { Hello::Engine.routes }



      it "routes to #sign_up" do
        get("/sign_up").should route_to("hello/classic/registration#sign_up")
      end

          it "routes to #create" do
            post("/sign_up").should route_to("hello/classic/registration#create")
          end

              it "routes to #after_sign_up" do
                get("/after_sign_up").should route_to("hello/classic/registration#after_sign_up")
              end




      it "routes to #sign_in" do
        get("/sign_in").should route_to("hello/classic/registration#sign_in")
      end

          it "routes to #authenticate" do
            post("/sign_in").should route_to("hello/classic/registration#authenticate")
          end

              it "routes to #after_sign_in" do
                get("/after_sign_in").should route_to("hello/classic/registration#after_sign_in")
              end

      it "routes to #forgot_password" do
        get("/forgot_password").should route_to("hello/classic/registration#forgot")
      end

          it "routes to #ask" do
            post("/forgot_password").should route_to("hello/classic/registration#ask")
          end

              it "routes to #after_forgot" do
                get("/after_forgot").should route_to("hello/classic/registration#after_forgot")
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
