require_dependency 'hello/application_controller'

module Hello
  class LocaleController < ApplicationController
    dont_kick_people

    # GET /hello/locale
    def index
      respond_to do |format|
        format.html { render 'hello/internationalization/locale/index' }
        format.json { render json: { locales: available_locales_with_names } }
      end
    end

    # POST /hello/locale
    def update
      entity = UpdateLocaleEntity.new(params['locale'])

      set_locale(entity.locale)

      respond_to do |format|
        format.html { redirect_to :back, notice: entity.success_message }
        format.json { fail JsonNotSupported }
      end
    end
  end
end
