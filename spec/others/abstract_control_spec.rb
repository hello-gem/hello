require 'spec_helper'

describe "AbstractControl" do

  it "Acts as an abstract class" do
    control = Hello::AbstractControl.new(nil, nil)
    expect { control.success }.to raise_error(NotImplementedError)
    expect { control.failure }.to raise_error(NotImplementedError)
  end

end
