module Hello
  module Concerns
    module ClassicSignInOnSuccess

      def on_success
        access_token = sign_in!(@sign_in.user, expires_at)

        respond_to do |format|
          format.html { redirect_to session.delete(:url) || '/' }
          format.json { render json: access_token.as_json_web_api, status: :created }
        end
      end

      private

      def expires_at
        if params[:keep_me]
          30.days.from_now
        else
          30.minutes.from_now
        end
      end

    end
  end
end
