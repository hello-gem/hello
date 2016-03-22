require 'spec_helper'

module Hello
  describe SessionsController do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/hello/sign_out').to route_to('hello/sessions#sign_out')
      end
    end
  end
end
