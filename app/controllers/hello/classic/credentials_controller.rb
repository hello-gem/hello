require_dependency "hello/application_controller"

module Hello
module Classic
  class CredentialsController < ApplicationController
    before_actions do
      # actions(:index)   { @credentials = hello_user.credentials }
      # actions(:new)     { @credential   = hello_user.credentials.build }
      # actions(:create)  { @credential   = hello_user.credentials.build(credential_params) }
      # actions(:show, :edit, :update, :destroy)  {
      actions(:update, :email, :username, :password)  {
        @credential = hello_user.credentials.classic.find(params[:id])
      }
    end

    # # GET /hello/classic/credentials
    # def index
    # end

    # # GET /hello/classic/credentials/new
    # def new
    # end

    # # POST /hello/classic/credentials
    # def create
    #   if @credential.save
    #     redirect_to @credential, notice: 'Your credential was successfully created.'
    #   else
    #     render :new
    #   end
    # end


    # # GET /hello/classic/credentials/1
    # def show
    # end

    # GET /hello/classic/credentials/1/email
    def email
    end

    # GET /hello/classic/credentials/1/username
    def username
    end

    # GET /hello/classic/credentials/1/password
    def password
    end

    # # GET /hello/classic/credentials/1/edit
    # def edit
    # end

        # PATCH/PUT /hello/classic/credentials/1
        def update
          if @credential.update(credential_params)
            redirect_to hello.user_path, notice: 'Your credential was successfully updated.'
          else
            the_action = credential_params.keys.first
            render the_action
          end
        end

    # # DELETE /hello/classic/credentials/1
    # def destroy
    #   if @credential.destroy
    #     redirect_to credentials_url, notice: 'Your credential was successfully destroyed.'
    #   else
    #     render :edit
    # end

    private

      # Only allow a trusted parameter "white list" through.
      def credential_params
        params.require(:credential).permit(:email, :username, :password)
      end
  end

end
end
