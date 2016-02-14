require 'spec_helper'

module Hello
  describe 'Browser Locale' do
    routes { Hello::Engine.routes }

    # As a Guest
    # I can see the website
    # So I don't face missing translation issues

    describe LocaleController do
      describe 'Browser locale or default' do
        hash = {
          nil                       => 'en',
          'en-US,en;q=0.8,pt;q=0.6' => 'en',
          'en-US;q=0.8,pt;q=0.6'    => 'en',
          'en-US;q=0.8,pt;q=0.6'    => 'en',
          'en'                      => 'en',
          'de-AT'                   => 'en',
          'de-CH'                   => 'en',
          'de'                      => 'en',
          'en-AU'                   => 'en',
          'en-BORK'                 => 'en',
          'en-CA'                   => 'en',
          'en-GB'                   => 'en',
          'en-IND'                  => 'en',
          'nep'                     => 'en',
          'es'                      => 'es',
          'fa'                      => 'en',
          'fr'                      => 'fr',
          'fr-FR'                   => 'fr',
          'fr-CA'                   => 'fr',
          'fr-CH'                   => 'fr',
          'it'                      => 'en',
          'ja'                      => 'en',
          'ko'                      => 'en',
          'nb-NO'                   => 'en',
          'nl'                      => 'en',
          'pl'                      => 'pl',
          'pt'                      => 'pt-BR',
          'pt-BR'                   => 'pt-BR',
          'ru'                      => 'en',
          'sk'                      => 'en',
          'vi'                      => 'en',
          'zh'                      => 'zh-CN',
          'zh-CN'                   => 'zh-CN',
          'zh-HK'                   => 'zh-CN',
          'zh-MO'                   => 'zh-CN',
          'zh-SG'                   => 'zh-CN',
          'zh-TW'                   => 'zh-CN',
          'zh-YUE'                  => 'zh-CN',
        }

        hash.each do |value, expected|
          it "#{value || 'nil'} \t -> #{expected}" do
            @request.headers['HTTP_ACCEPT_LANGUAGE'] = value if value
            get :index
            expect(response.status).to eq(200)
            expect(response.status_message).to eq('OK')
            expect(session['locale'].to_s).to eq(expected)
          end
        end
      end
    end
  end
end
