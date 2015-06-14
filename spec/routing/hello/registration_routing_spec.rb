require "spec_helper"

module Hello

    describe "routing" do
      routes { Hello::Engine.routes }



      it "routes to #index" do
        expect(get("/sign_up")).to route_to("hello/email_sign_up#index")
      end

          it "routes to #create" do
            expect(post("/sign_up")).to route_to("hello/email_sign_up#create")
          end




      it "routes to #index" do
        expect(get("/sign_in")).to route_to("hello/email_sign_in#index")
      end

          it "routes to #authenticate" do
            expect(post("/sign_in")).to route_to("hello/email_sign_in#authenticate")
          end

              it "routes to #authenticated" do
                expect(get("/authenticated")).to route_to("hello/email_sign_in#authenticated")
              end





      it "routes to #index" do
        expect(get("/password/forgot")).to route_to("hello/email_forgot_password#index")
      end

          it "routes to #remember" do
            expect(post("/password/forgot")).to route_to("hello/email_forgot_password#remember")
          end

              it "routes to #remembered" do
                expect(get("/password/remembered")).to route_to("hello/email_forgot_password#remembered")
              end




      it "routes to #reset_token" do
        expect(get("/password/reset/123")).to route_to("hello/reset_password#reset_token", token: '123')
      end

          it "routes to #index" do
            expect(get("/password/reset")).to route_to("hello/reset_password#index")
          end

              it "routes to #save" do
                expect(post("/password/reset")).to route_to("hello/reset_password#save")
              end

                  it "routes to #done" do
                    expect(get("/password/reset/done")).to route_to("hello/reset_password#done")
                  end

      



          
    end
end
