module Hello
  module Business
    class Base
      include ActiveModel::Model

      def errors
        @errors ||= ActiveModel::Errors.new(self)
      end

      def error_message(extra = {})
        t('error', { count: errors.count }.merge(extra))
      end

      def alert_message(extra = {})
        t('alert', extra)
      end

      def success_message(extra = {})
        t('success', extra)
      end

      def t(key, extra = {})
        I18n.t("#{i18n_scope}.#{key}", extra)
      end

      protected

      def i18n_scope
        self.class.name.underscore.tr('/', '.')
      end
    end
  end
end
