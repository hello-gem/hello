module Hello
  module RailsController
    extend ActiveSupport::Concern

    autoload :RestrictByRole, 'hello/rails_controller/restrict_by_role'

    module ClassMethods
      def sign_out!(options = {})
        before_action(options) { sign_out! }
      end

      def kick(*args)
        options, roles = Hello::Utils.trailing_options(args)
        before_action(options) { kick(*roles) }
      end

      def dont_kick(*args)
        options, roles = Hello::Utils.trailing_options(args)
        before_action(options) { dont_kick(*roles) }
      end

      def dont_kick_people
        # :)
      end

      def sudo_mode(options = {})
        before_action(options) { sudo_mode }
      end
    end

    included do
      around_action :hello_around_action

      helper_method :classic_sign_up_disabled,
                    :current_user, :current_accesses, :current_access,
                    :signed_in?, :is_current_access?, :sudo_mode?

      delegate :sign_in!, :sign_out!, :signed_in?,
               :current_user, :is_current_user?,
               :current_access, :current_accesses, :is_current_access?,
               :session_token=, :session_tokens,
               to: :hello_manager

      delegate :kick, :dont_kick,
               to: :restrict_by_role
    end

    def hello_manager
      env['hello'] ||= Hello::RequestManager.create(request)
    end



    def classic_sign_up_disabled
      Hello.configuration.classic_sign_up_disabled || action_name=='disabled'
    end

    def hello_store_url_on_session!
      session[:url] = url_for(params.permit!.merge(only_path: true))
    end



    def sudo_mode?
      current_access && current_access.sudo_expires_at.future?
    end

    def sudo_mode
      unless sudo_mode?
        hello_store_url_on_session!
        render_sudo_mode_form
      end
    end

    def render_sudo_mode_form
      render 'hello/authentication/sudo_mode/form'
    end



    private

    def restrict_by_role
      @_hello_rbr ||= RestrictByRole.new(self)
    end


    def use_locale(locale)
      locale ||= current_user && current_user.locale
      locale ||= session['locale']
      locale ||= recommended_locale.to_s

      I18n.locale = session['locale'] = locale
    end

    def hello_around_action(&block)
      use_locale(nil)

      if current_user
        # begin keep-alive
        Access.cached_destroy_all_expired
        current_access.keep_alive!
        expires_in = view_context.time_ago_in_words(current_access.expires_at)
        logger.info "  #{'Hello Session'.bold.light_blue} expires in #{expires_in}"
        # end keep-alive

        Thread.current['Hello.destroying_user'] = nil
        Time.use_zone(current_user.time_zone, &block)
        Thread.current['Hello.destroying_user'] = nil
      else
        yield
      end
    end

    def recommended_locale
      y = Hello.configuration.locales
      x = http_accept_language.compatible_language_from(y)
      x || I18n.default_locale
    end

  end
end
