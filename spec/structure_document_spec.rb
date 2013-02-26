require 'spec_helper'

describe DmozSax::StructureDocument do
  #it 'can parse a real structure.rdf.u8 document' do
  #  parser = Nokogiri::XML::SAX::Parser.new(DmozSax::StructureDocument.new)
  #  parser.parse(File.open('/opt/data/DMOZ/structure.rdf.u8'))
  #end

  it 'can parse a sample structure.rdf.u8 document' do

    topics = []
    aliases = []

    document = DmozSax::StructureDocument.new
    document.on_topic = lambda {|t| topics << t }

    document.on_alias = lambda {|a| aliases << a }

    parser = Nokogiri::XML::SAX::Parser.new(document)
    parser.parse(File.open('spec/samples/structure_sample.rdf.u8'))
    topics.count.should == 2
    topics[1].title.should == 'Arts'
    topics[1].path.should == ['Arts']
    topics[1].description.should include 'aesthetic objects'
    topics[1].cid.should == 381773

    aliases.count.should == 2
    aliases[0].title.should == 'Publishers'
    aliases[0].path.should == ['Business','Publishing and Printing','Publishing','Books','Arts']
  end
end
