require_dependency "hello/application_controller"

module Hello
  class LocaleController < ApplicationController

    # GET /hello/locale
    def index
      respond_to do |format|
        format.html {  }
        format.json { render json: {locales: available_locales_with_names} }
      end
    end

    # POST /hello/locale
    def update
      excluded_unsupported_locales = ([params['locale']] & Hello.available_locales)
      session['locale'] = excluded_unsupported_locales.first || 'en'
      set_locale

      respond_to do |format|
        format.html { redirect_to :back, notice: t("hello.messages.locale.notice") }
        format.json { raise JsonNotSupported }
      end
    end

  end
end
