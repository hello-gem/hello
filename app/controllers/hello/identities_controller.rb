require_dependency "hello/application_controller"

module Hello
  class IdentitiesController < ApplicationController
    before_actions do
      # actions(:index)   { @identities = hello_user.identities }
      # actions(:new)     { @identity   = hello_user.identities.build }
      # actions(:create)  { @identity   = hello_user.identities.build(identity_params) }
      actions(:show, :edit, :update, :destroy)  {
        @identity = hello_user.identities.strategy_password.find(params[:id])
      }
    end

    # # GET /hello/identities
    # def index
    # end

    # # GET /hello/identities/new
    # def new
    # end

    # # POST /hello/identities
    # def create
    #   if @identity.save
    #     redirect_to @identity, notice: 'Your identity was successfully created.'
    #   else
    #     render :new
    #   end
    # end


    # GET /hello/identities/1
    def show
      render :edit
    end

    # # GET /hello/identities/1/edit
    # def edit
    # end

        # PATCH/PUT /hello/identities/1
        def update
          if @identity.update(identity_params)
            redirect_to @identity, notice: 'Your identity was successfully updated.'
          else
            render :edit
          end
        end

    # # DELETE /hello/identities/1
    # def destroy
    #   if @identity.destroy
    #     redirect_to identities_url, notice: 'Your identity was successfully destroyed.'
    #   else
    #     render :edit
    # end

    private

      # Only allow a trusted parameter "white list" through.
      def identity_params
        params.require(:identity).permit(:email, :username)
      end
  end
end
