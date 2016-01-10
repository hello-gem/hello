module Hello
  module Railsy
    module Helper
      def human_current_locale
        t('hello.others.locale')
      end

      def current_locale
        session['locale']
      end
    end
  end
end

if defined? ActionView::Base
  ActionView::Base.class_eval do
    include Hello::Railsy::Helper
  end
end
