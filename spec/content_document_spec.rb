require 'spec_helper'

describe DmozSax::ContentDocument do
  it 'can parse a sample content.rdf.u8 document' do

    topics = []
    pages = []

    document = DmozSax::ContentDocument.new
    document.on_topic = lambda {|t| topics << t }
    document.on_external_page = lambda {|t| pages << t }

    parser = Nokogiri::XML::SAX::Parser.new(document)
    parser.parse(File.open('spec/samples/content_sample.rdf.u8'))

    topics[3].path.should == ['Top', 'Arts', 'Animation', 'Cartoons', 'Titles', 'P','PB & J Otter']
    pages[4].path.should  == ['Top', 'Arts', 'Animation', 'Cartoons', 'Titles', 'P','PB & J Otter']
  end
end
