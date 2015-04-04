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
      #
      # Filter params
      #
      excluded_unsupported_locales = ([params['locale']] & Hello.available_locales)
      locale = excluded_unsupported_locales.first || 'en'

      #
      # Update Database / Session
      #
      if hello_user
        hello_user.update!(locale: locale)
      else
        session['locale'] = locale
      end

      #
      # Ensure Thread
      #
      hello_ensure_thread_locale


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
