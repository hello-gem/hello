require 'spec_helper'

describe Credential do
  example 'Validations' do
    expect(subject.valid?).to eq(true)
    expect(subject.errors.messages).to eq({})
  end

  example 'Saving Validations' do
    expect(subject.save).to eq(nil)
    expect(subject.errors.messages).to eq({:user => ["can't be blank"]})
  end
end
