require 'spec_helper'

module Hello
  describe Management::AccessesController do
    describe 'routing' do
      routes { Hello::Engine.routes }

      it 'routes to #index' do
        expect(get: '/accesses').to route_to('hello/management/accesses#index')
      end

      it 'routes to #destroy' do
        expect(delete: '/accesses/1').to route_to('hello/management/accesses#destroy', id: '1')
      end
    end
  end
end
