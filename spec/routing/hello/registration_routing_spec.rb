require 'spec_helper'

module Hello
  describe 'routing' do
    routes { Hello::Engine.routes }

    it 'routes to #index' do
      expect(get('/sign_up')).to route_to('hello/classic_sign_up#index')
    end

    it 'routes to #create' do
      expect(post('/sign_up')).to route_to('hello/classic_sign_up#create')
    end

    it 'routes to #index' do
      expect(get('/sign_in')).to route_to('hello/classic_sign_in#index')
    end

    it 'routes to #authenticate' do
      expect(post('/sign_in')).to route_to('hello/classic_sign_in#authenticate')
    end
  end
end
