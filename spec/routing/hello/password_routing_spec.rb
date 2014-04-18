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

      
    end
  end
end
