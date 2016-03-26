require 'spec_helper'

module Hello
  describe Management::ProfilesController do
    describe 'routing' do
      routes { Hello::Engine.routes }

      it 'routes to #show' do
        expect(get('/profile')).to route_to('hello/management/profiles#show')
      end

      it 'routes to #update' do
        expect(patch('/profile')).to route_to('hello/management/profiles#update')
      end
    end
  end
end
