require 'spec_helper'

module Hello
  describe LocaleController do
    describe 'routing' do
      routes { Hello::Engine.routes }

      it 'routes to #index' do
        expect(get('/locale')).to route_to('hello/locale#index')
      end

      it 'routes to #update' do
        expect(post('/locale')).to route_to('hello/locale#update')
      end
    end
  end
end
