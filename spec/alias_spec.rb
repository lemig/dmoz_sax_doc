require 'spec_helper'

describe DmozSax::Alias do
  it "has a name and path parsed from a string" do
    a = DmozSax::Alias.new("Publishing:Top/Arts/Business/Publishing")
    a.path.name.should == 'Publishing'
    a.path.to_s.should == '/Arts/Business/Publishing'
  end
end
