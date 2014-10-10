require 'spec_helper'

describe "Novice" do

  describe "Becomes User" do
    it "Success" do
      when_sign_up_as_a_novice

      click_button "Continue"
      # expect(current_path).to eq root_path
      expect(current_path).to eq '/hello/user' # because there is no root path in this app
    end

    # it "Alert" do
    #   pending
    # end
  end

end
