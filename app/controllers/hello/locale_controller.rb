require_dependency "hello/application_controller"

module Hello
  class LocaleController < ApplicationController

    # access to all roles

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
      
      hello_user && hello_user.update!(locale: session['locale'])

      entity = UpdateLocaleEntity.new

      respond_to do |format|
        format.html { redirect_to :back, notice: entity.success_message }
        format.json { raise JsonNotSupported }
      end
    end

  end
end
