require_dependency "hello/application_controller"

#
# IT IS RECOMMENDED THAT YOU DO NOT OVERRIDE THIS FILE IN YOUR APP
#

module Hello
  class EmailsController < ApplicationController
    
    restrict_to_users
    
    before_actions do
      all { restrict_access_to_sudo_mode }
      # only(:index)   { @credentials = hello_user.credentials }
      # only(:new)     { @credential   = hello_user.credentials.build }
      # only(:create)  { @credential   = hello_user.credentials.build(credential_params) }
      # only(:show, :edit, :update, :destroy)  {
      only(:show, :update)  {
        @credential = hello_user.credentials.classic.find(params[:id])
      }
    end

    # # GET /hello/emails
    # def index
    # end

    # # GET /hello/emails/new
    # def new
    # end

    # # POST /hello/emails
    # def create
    #   if @credential.save
    #     redirect_to @credential, notice: 'Your credential was successfully created.'
    #   else
    #     render :new
    #   end
    # end


    # GET /hello/emails/1
    def show
    end

        # PATCH/PUT /hello/emails/1
        def update
          if @credential.update(credential_params)
            puts "TODO: reset email secondary fields".on_red
            flash[:notice] = entity.success_message
            redirect_to hello.user_path
          else
            flash[:alert] = entity.alert_message
            render action: 'show'
          end
        end

    # # DELETE /hello/emails/1
    # def destroy
    #   if @credential.destroy
    #     redirect_to credentials_url, notice: 'Your credential was successfully destroyed.'
    #   else
    #     render :edit
    # end

    private

      # Only allow a trusted parameter "white list" through.
      def credential_params
        params.require(:credential).permit(:email)
      end

      def entity
        @entity ||= UpdateFieldEntity.new('email')
      end
  end

end
