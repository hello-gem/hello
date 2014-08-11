require 'spec_helper'

describe "Config" do

  it "configurations work" do
    c = Hello.config(:sign_up)
    expect(c.success_block).not_to eq(nil)
    expect(c.fields).to match_array [:name, :email, :username, :password, :city]
  end

end
