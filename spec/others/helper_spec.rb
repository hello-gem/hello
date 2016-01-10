require 'spec_helper'

describe 'Helper' do
  it 'hello_locale_select_options' do
    obj = Object.new
    obj.extend Hello::Railsy::Controller::LocaleConcern
    expect(obj.hello_locale_select_options).to be_an Array
    expect(obj.hello_locale_select_options).to include %w(English en)
  end
end
