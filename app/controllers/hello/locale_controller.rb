require_dependency "hello/application_controller"

module Hello
  class LocaleController < ApplicationController

    dont_kick_people

    # GET /hello/locale
    def index
      respond_to do |format|
        format.html {  }
        format.json { render json: {locales: available_locales_with_names} }
      end
    end

    # POST /hello/locale
    def update
      #
      # Filter params
      #
      excluded_unsupported_locales = ([params['locale']] & Hello.available_locales)
      locale = excluded_unsupported_locales.first || 'en'

      #
      # Update Database / Session
      #
      current_user && current_user.update!(locale: locale)
      set_session_locale(locale)

      #
      # Render Response
      #
      entity = UpdateLocaleEntity.new

      respond_to do |format|
        format.html { redirect_to :back, notice: entity.success_message }
        format.json { raise JsonNotSupported }
      end
    end

  end
end
