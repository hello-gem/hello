require_dependency "hello/application_controller"

module Hello
module Classic
  class IdentitiesController < ApplicationController
    before_actions do
      # actions(:index)   { @identities = hello_user.identities }
      # actions(:new)     { @identity   = hello_user.identities.build }
      # actions(:create)  { @identity   = hello_user.identities.build(identity_params) }
      # actions(:show, :edit, :update, :destroy)  {
      actions(:update, :email, :username, :password)  {
        @identity = hello_user.identities.classic.find(params[:id])
      }
    end

    # # GET /hello/classic/identities
    # def index
    # end

    # # GET /hello/classic/identities/new
    # def new
    # end

    # # POST /hello/classic/identities
    # def create
    #   if @identity.save
    #     redirect_to @identity, notice: 'Your identity was successfully created.'
    #   else
    #     render :new
    #   end
    # end


    # # GET /hello/classic/identities/1
    # def show
    # end

    # GET /hello/classic/identities/1/email
    def email
    end

    # GET /hello/classic/identities/1/username
    def username
    end

    # GET /hello/classic/identities/1/password
    def password
    end

    # # GET /hello/classic/identities/1/edit
    # def edit
    # end

        # PATCH/PUT /hello/classic/identities/1
        def update
          if @identity.update(identity_params)
            redirect_to hello.user_path, notice: 'Your identity was successfully updated.'
          else
            the_action = identity_params.keys.first
            render the_action
          end
        end

    # # DELETE /hello/classic/identities/1
    # def destroy
    #   if @identity.destroy
    #     redirect_to identities_url, notice: 'Your identity was successfully destroyed.'
    #   else
    #     render :edit
    # end

    private

      # Only allow a trusted parameter "white list" through.
      def identity_params
        params.require(:identity).permit(:email, :username, :password)
      end
  end

end
end
