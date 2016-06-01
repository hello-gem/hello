require 'spec_helper'

module Hello
  describe Management::ProfilesController do
    describe 'routing' do
      routes { Hello::Engine.routes }

      it 'routes to #show too' do
        expect(get('/')).to route_to('hello/management/profiles#show')
      end

      it 'routes to #show' do
        expect(get('/profile')).to route_to('hello/management/profiles#show')
      end

      it 'routes to #update' do
        expect(patch('/profile')).to route_to('hello/management/profiles#update')
      end

      it 'routes to #cancel' do
        expect(get('/profile/cancel')).to route_to('hello/management/profiles#cancel')
      end

      it 'routes to #destroy' do
        expect(delete('/profile')).to route_to('hello/management/profiles#destroy')
      end
    end
  end
end
