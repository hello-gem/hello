require 'spec_helper'

module Hello
  describe 'Configuration' do
    let(:hello_config) { Hello.configuration }
    let(:rails_config) { Rails.configuration.hello }

    describe 'Works With Rails' do
      it 'is the same instance' do
        expect(hello_config).to eq(rails_config)
        expect(hello_config.object_id).to eq(rails_config.object_id)
      end

      it 'Sets in Hello, Gets in Rails' do
        hello_config.mailer_sender = 'foo'
        expect(rails_config.mailer_sender).to eq('foo')
      end

      it 'Sets in Rails, Gets in Hello' do
        rails_config.mailer_sender = 'bar'
        expect(hello_config.mailer_sender).to eq('bar')
      end
    end
  end
end
