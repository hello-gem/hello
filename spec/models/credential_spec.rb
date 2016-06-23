require 'spec_helper'

describe Credential do
  example 'Validations' do
    subject.valid?
    expect(subject.errors.messages).to eq(user: ["can't be blank"])
  end
end
