module Hello
  class UpdateLocaleEntity < AbstractEntity

    def success_message(extra={})
      super(locale_name: I18n.t('hello.others.locale'))
    end

  end
end