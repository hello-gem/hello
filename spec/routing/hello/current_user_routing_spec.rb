require 'spec_helper'

module Hello
  describe Management::CurrentUsersController do
    describe 'routing' do
      routes { Hello::Engine.routes }

      it 'routes to #show' do
        expect(get('/current_user')).to route_to('hello/management/current_users#show')
      end

      it 'routes to #update' do
        expect(patch('/current_user')).to route_to('hello/management/current_users#update')
      end
    end
  end
end
