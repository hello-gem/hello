require "spec_helper"

module Hello
  describe PasswordController do
    describe "routing" do
      routes { Hello::Engine.routes }

      it "routes to #sign_up" do
        get("/password/sign_up").should route_to("hello/password#sign_up")
      end

          it "routes to #create" do
            post("/password/sign_up").should route_to("hello/password#create")
          end

              it "routes to #sign_up_welcome" do
                get("/password/sign_up/welcome").should route_to("hello/password#sign_up_welcome")
              end

      it "routes to #sign_in" do
        get("/password/sign_in").should route_to("hello/password#sign_in")
      end

          it "routes to #authenticate" do
            post("/password/sign_in").should route_to("hello/password#authenticate")
          end

              it "routes to #sign_in_welcome" do
                get("/password/sign_in/welcome").should route_to("hello/password#sign_in_welcome")
              end

      it "routes to #forgot" do
        get("/password/forgot").should route_to("hello/password#forgot")
      end

          it "routes to #ask" do
            post("/password/forgot").should route_to("hello/password#ask")
          end

              it "routes to #forgot_welcome" do
                get("/password/forgot/welcome").should route_to("hello/password#forgot_welcome")
              end

      it "routes to #reset" do
        get("/password/reset").should route_to("hello/password#reset")
      end

          it "routes to #save" do
            post("/password/reset").should route_to("hello/password#save")
          end

              it "routes to #reset_welcome" do
                get("/password/reset/welcome").should route_to("hello/password#reset_welcome")
              end
      
    end
  end
end
