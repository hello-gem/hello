require_dependency 'hello/application_controller'

module Hello
  class SessionsController < ApplicationController
    dont_kick_people

    before_actions do
      only(:index) { @accesses = current_accesses }
      only(:show, :destroy) do
        unless @access = find_access
          respond_to do |format|
            format.html { redirect_to hello.sessions_path, notice: 'Your Session Was Expired!' }
            format.json { head :reset_content }
          end
        end
      end
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

      respond_to do |format|
        format.html { redirect_to hello.sessions_path, notice: t('hello.entities.session_switch.success') }
        format.json { head :reset_content }
      end
    end

    # DELETE /hello/sessions/1
    def destroy
      sign_out!(@access)

      respond_to do |format|
        format.html { redirect_to hello.sessions_path, notice: t('hello.entities.session_forget.success') }
        format.json { head :reset_content }
      end
    end

    # get /hello/sign_out
    def sign_out
      sign_out!

      respond_to do |format|
        format.html { redirect_to '/', notice: t('hello.entities.sign_out.success') }
        format.json { head :reset_content }
      end
    end

    private

    def find_access
      current_accesses.find { |at| at.id.to_s == params[:id] }
    end

    def render_list
      render 'hello/authentication/sessions/index'
    end

    def render_new
      render 'hello/authentication/sessions/new'
    end
  end
end
