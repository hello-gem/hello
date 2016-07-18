require 'spec_helper'

describe Credential do
  example 'Validations' do
    expect(subject.valid?).to eq(true)
    expect(subject.errors.messages).to eq({})
  end

  example 'Saving Validations' do
    # can save without a user
    expect(subject.save).to eq(true)
    expect(subject.errors.messages).to eq({})

    # cannot update without a user
    expect(subject.save).to eq(false)
    expect(subject.errors.messages).to eq({:user => ["can't be blank"]})
  end
end
