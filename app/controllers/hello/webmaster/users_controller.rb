require_dependency "hello/application_controller"

module Hello
  class Webmaster::UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy, :impersonate]

    dont_kick :webmaster, except: [:impersonate_back]

    # GET /webmaster/users
    def index
      @users = ::User.order(:id)
    end

    # # GET /webmaster/users/1
    # def show
    # end

    # # GET /webmaster/users/new
    # def new
    #   @user = ::User.new
    # end

    # # GET /webmaster/users/1/edit
    # def edit
    # end

    # # POST /webmaster/users
    # def create
    #   @user = ::User.new(user_params)

    #   if @user.save
    #     redirect_to @user, notice: 'User was successfully created.'
    #   else
    #     render :new
    #   end
    # end

    # # PATCH/PUT /webmaster/users/1
    # def update
    #   if @user.update(user_params)
    #     redirect_to @user, notice: 'User was successfully updated.'
    #   else
    #     render :edit
    #   end
    # end

    # # DELETE /webmaster/users/1
    # def destroy
    #   if @user.destroy
    #     redirect_to users_url, notice: 'User was successfully destroyed.'
    #   else
    #     render :edit
    #   end
    # end




    # POST /webmaster/users/1/impersonate
    def impersonate
      hello_impersonate(@user)

      entity = ImpersonateEntity.new(@user)
      flash[:notice] = entity.success_message
      redirect_to '/'
    end

    # GET /webmaster/users/impersonate_back
    def impersonate_back
      hello_back_to_myself

      entity = ImpersonateBackEntity.new
      flash[:notice] = entity.success_message
      redirect_to hello.webmaster_path
    end



    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = ::User.find(params[:id])
      end

      # # Only allow a trusted parameter "white list" through.
      # def user_params
      #   params.require(:user).permit(:username, :name, :role, :locale, :time_zone)
      # end
  end
end
