require 'spec_helper'

module Hello
  describe I18n do
    def flat_hash(h, f = [], g = {})
      return g.update(f => h) unless h.is_a? Hash
      h.each { |k, r| flat_hash(r, f + [k], g) }
      g
    end

    def flat_i18n_hello(locale)
      flat_hash I18n.t('hello', locale: locale)
    end

    def h_en
      @h_en ||= flat_i18n_hello(:en)
    end

    def extract_string_replacement(text)
      regex = /%{(\w*)}/
      text.scan(regex)
    end

    it 'extract_string_replacement' do
      test_text = 'aaaaa %{bbb} c %{ddd} eeeee'
      scandata = extract_string_replacement(test_text)
      expect(scandata).to eq([['bbb'], ['ddd']])
    end

    describe 'Consistent with ENGLISH' do

      def consistency_wrap(locale, &_block)
        h_lo = flat_i18n_hello(locale)

        array_en = Array(h_en)
        array_lo = Array(h_lo)

        array_en.size.times do |i|
          @en_key  = array_en[i][0]
          en_val   = array_en[i][1]

          @lo_key  = array_lo[i][0]
          lo_val   = array_lo[i][1]

          @en_vars = extract_string_replacement(en_val)
          @lo_vars = extract_string_replacement(lo_val)

          yield
        end
      end

      available_locales = Dir[Hello::ROOT.join('config', 'locales', '**', '*.yml')].map { |s| s.split('.')[-2] }

      available_locales.each do |locale|
        describe "#{locale} consistency" do
          it 'Keys are consistent' do
            consistency_wrap(locale) do
              error_message = "I18n '#{locale}' does not match 'en'.\nExpected key '#{@lo_key}' but found key '#{@en_key}'"
              expect(@lo_key).to eq(@en_key), error_message
            end
          end

          it 'Variables are consistent' do
            consistency_wrap(locale) do
              error_message = "I18n '#{locale}' does not match 'en'.\nExpected key '#{@lo_key}' with values '#{@en_vars}', but found '#{@lo_vars}' instead."
              expect(@lo_vars).to eq(@en_vars), error_message
            end
          end
        end
      end
    end
  end
end
