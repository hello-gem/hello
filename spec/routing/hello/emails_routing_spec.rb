require 'spec_helper'

module Hello
  describe EmailsController do
    describe 'routing' do
      routes { Hello::Engine.routes }

      it 'routes to #index' do
        expect(get: '/emails').to route_to('hello/emails#index')
      end

      it 'routes to #create' do
        expect(post: '/emails').to route_to('hello/emails#create')
      end

      it 'routes to #destroy' do
        expect(delete: '/emails/1').to route_to('hello/emails#destroy', id: '1')
      end

      it 'routes to #deliver' do
        expect(post('/emails/1/deliver')).to route_to('hello/emails#deliver', id: '1')
      end

      #
      # CONFIRM EMAIL
      #

      it 'routes to #confirm' do
        expect(get('/emails/1/confirm/123')).to route_to('hello/confirm_emails#confirm', id: '1', token: '123')
      end

      it 'routes to #expired_token' do
        expect(get: '/emails/expired_confirmation_token').to route_to('hello/confirm_emails#expired_confirmation_token')
      end
    end
  end
end
