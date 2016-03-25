require 'spec_helper'

module Hello
  module Authentication
    describe SudoModeController do
      describe 'routing' do
        routes { Hello::Engine.routes }

        it 'routes to #form' do
          expect(get: '/sudo_mode').to route_to('hello/authentication/sudo_mode#form')
        end

        it 'routes to #authenticate' do
          expect(patch: '/sudo_mode').to route_to('hello/authentication/sudo_mode#authenticate')
        end

        it 'routes to #expire' do
          expect(get: '/sudo_mode/expire').to route_to('hello/authentication/sudo_mode#expire')
        end
      end
    end
  end
end
