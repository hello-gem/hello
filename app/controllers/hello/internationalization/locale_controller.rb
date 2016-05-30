require_dependency 'hello/application_controller'

module Hello
  module Internationalization
    class LocaleController < ApplicationController
      dont_kick_people

      # GET /hello/locale
      def index
        respond_to do |format|
          format.html { render 'hello/internationalization/locale/index' }
          format.json { render json: { locales: view_context.available_locales_with_names } }
        end
      end

      # POST /hello/locale
      def update
        entity = UpdateLocaleEntity.new(params['locale'])

        current_user && current_user.update!(locale: entity.locale)
        use_locale(entity.locale)

        respond_to do |format|
          format.html { redirect_to :back, notice: entity.success_message }
          format.json { fail Hello::Errors::JsonNotSupported }
        end
      end
    end
  end
end
