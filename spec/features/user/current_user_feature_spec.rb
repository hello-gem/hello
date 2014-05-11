require 'spec_helper'

describe "credential" do
describe "password" do


  it "current user" do
    when_sign_up_with_standard_data
    # then_I_should_be_logged_out
    # when_sign_in_with_standard_data
    then_I_should_be_logged_in

    #
    # Session gets destroyed on server-side
    #
    Session.destroy_all
    visit hello.root_path
    then_I_should_be_logged_out
  end


end
end