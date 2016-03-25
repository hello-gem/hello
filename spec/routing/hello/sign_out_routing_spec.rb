require 'spec_helper'

module Hello
  describe Authentication::SessionsController do
    describe 'routing' do
      it 'routes to #sign_out' do
        expect(get: '/hello/sign_out').to route_to('hello/authentication/sessions#sign_out')
      end
    end
  end
end
