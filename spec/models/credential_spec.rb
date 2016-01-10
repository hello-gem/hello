require 'spec_helper'

describe Credential do
  example 'Validations' do
    subject.valid?
    expect(subject.errors.messages).to eq(user: ["can't be blank"],
                                          type: ["can't be blank", 'is not included in the list'])
  end
end
