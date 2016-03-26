module Hello
  module Concerns
    module UpdateProfileOnSuccess

      def on_success
        respond_to do |format|
          format.html { redirect_to hello.profile_path }
          format.json { render json: @user.as_json_web_api, status: :ok }
        end
      end

    end
  end
end
