# Learn more at config/initializers/hello.rb
#
module Hello
  module Extensions
    module EmailSignIn
      def success
        access_token = sign_in!(@sign_in.user, expires_at)

        respond_to do |format|
          format.html { redirect_to session.delete(:url) || '/' }
          format.json { render json: access_token.as_json_web_api, status: :created }
        end
      end

      def failure
        respond_to do |format|
          format.html { render action: 'index' }
          format.json { render json: @sign_in.errors, status: :unprocessable_entity }
        end
      end

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
