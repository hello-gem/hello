require 'spec_helper'

module Hello
  describe Access do

    it "validations" do
      subject.valid?

      expect(subject.errors.messages).to eq({
        :user=>["can't be blank"],
        :user_agent_string=>["can't be blank"],
      })
    end

    describe "methods" do
      it "#full_device_name" do
        # Mock
        expect(Hello::DeviceName.instance).to receive(:parse)
        # When
        subject.full_device_name
      end
    end

  end
end
