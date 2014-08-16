require 'spec_helper'

module Hello

describe "Localization" do

  # As a Guest
  # I can see the website
  # So I don't face missing translation issues

  describe Classic::RegistrationController do
    routes { Hello::Engine.routes }

    describe "Browser locale or default" do

      # before { @s = given_I_have_a_classic_session }

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
        'es'                      => 'en',
        'fa'                      => 'en',
        'fr'                      => 'en',
        'it'                      => 'en',
        'ja'                      => 'en',
        'ko'                      => 'en',
        'nb-NO'                   => 'en',
        'nl'                      => 'en',
        'pl'                      => 'en',
        'pt'                      => 'pt-BR',
        'pt-BR'                   => 'pt-BR',
        'ru'                      => 'en',
        'sk'                      => 'en',
        'vi'                      => 'en',
        'zh'                      => 'en',
        'zh-CN'                   => 'en',
      }

      hash.each do |value, expected|
        it "#{value || 'nil'} \t -> #{expected}" do
          @request.headers['HTTP_ACCEPT_LANGUAGE'] = value if value
          post :ask, forgot_password: {login: 'foo'} # this is a good example because it triggers validations
          expect(response.status).to eq(200)
          expect(response.status_message).to eq("OK")
          expect(session['locale'].to_s).to eq(expected)
        end
      end

    end

    describe "Auto fills user locale on sign up" do
      
    end

    describe "Auto changes session locale on sign in" do
      
    end
  end


end
end



