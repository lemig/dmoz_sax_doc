require 'spec_helper'

describe DmozSax::VERSION do
  it "version number should be in a standard format" do
    DmozSax::VERSION.should =~ /^[\d]+[.][\d]+[.][\d]+([.-][a-z0-9]+)?$/
  end
end
