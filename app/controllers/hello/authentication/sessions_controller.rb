module Hello
  module Authentication
    class SessionsController < ApplicationController
      dont_kick_people

      before_actions do
        only(:index) { @accesses = current_accesses }
        only(:show, :destroy) { @access = find_access! }
      end

      # GET /hello/sessions
      def index
        render_list
      end

      # GET /hello/sessions/new
      def new
        render_new
      end

      # GET /hello/sessions/1
      def show
        self.session_token = @access.token

        business = Hello::Business::Authentication::SignIn.new

        respond_to do |format|
          format.html { redirect_to hello.sessions_path, notice: business.success_message }
          format.json { head :reset_content }
        end
      end

      # DELETE /hello/sessions/1
      def destroy
        sign_out!(@access)

        business = Hello::Business::Authentication::SignOut.new

        respond_to do |format|
          format.html { redirect_to hello.sessions_path, notice: business.success_message }
          format.json { head :reset_content }
        end
      end

      # get /hello/sign_out
      def sign_out
        sign_out!

        business = Hello::Business::Authentication::SignOut.new

        respond_to do |format|
          format.html { redirect_to '/', notice: business.success_message }
          format.json { head :reset_content }
        end
      end

      private

      def find_access!
        current_accesses.find { |at| at.id.to_s == params[:id] } || access_not_found!
      end

      def access_not_found!
        # we can re use the sign out message here
        business = Hello::Business::Authentication::SignOut.new
        respond_to do |format|
          format.html { redirect_to hello.sessions_path, notice: business.success_message }
          format.json { head :reset_content }
        end
      end

      def render_list
        render 'hello/authentication/sessions'
      end

      def render_new
        render 'hello/authentication/new_session'
      end
    end
  end
end
