require 'nokogiri'

module DmozSax
  class ContentDocument < Nokogiri::XML::SAX::Document

    attr_accessor :on_link, :on_external_page
    attr_accessor :name_parser, :time_parser

    def initialize
      super

      @name_parser = NameParser.new
      @time_parser = TimeParser.new
    end

    def characters string
      @buffer ||= ""
      @buffer << string
    end

    def start_element name, attributes = []
      @buffer = ""
      @name = name

      case name 
      when 'Topic'
        @topic = DmozSax::Topic.new attributes[0][1]
      when /^link/
        @link = DmozSax::Link.new 
        @on_link.call(@link) unless @on_link.nil? 
      when 'ExternalPage'
        @priority = 0
        @time = nil
        DmozSax::ExternalPage.new attributes[0][1]
      end
    end

    def end_element name
    
      case name
      when 'catid'
        @cid = @buffer.to_i
      when 'd:Description'
        @description = @buffer.strip
      when 'd:Title'
        @title = @buffer.strip.gsub('_', ' ')
      when 'topic'
        @on_topic.call(@topic) unless @on_topic.nil?
      when 'mediadate'
        @time = @time_parser.time_from @buffer
      when 'priority'
        @priority = @buffer.to_i
      when 'ExternalPage'
        @external.priority = @priority
        @external.title = @title
        @external.description = @description
        @external.path = @path
        @external.time = @time
        @on_external_page.call(@external) unless @on_external_page.nil?
      end
    end
  end
end
