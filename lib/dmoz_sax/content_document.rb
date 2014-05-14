require 'nokogiri'

module DmozSax
  class ContentDocument < Nokogiri::XML::SAX::Document

    attr_accessor :on_topic, :on_external_page
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
        unescaped = CGI.unescapeHTML(attributes[0][1])
        @topic = DmozSax::Topic.new unescaped
      when /^link/
        @topic.links << attributes[0][1]
      when 'ExternalPage'
        @priority = 0
        @time = nil
        @external = DmozSax::ExternalPage.new attributes[0][1]
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
      when 'Topic'
        @topic.cid = @cid
        @on_topic.call(@topic) unless @on_topic.nil?
      when 'topic'
        @path = DmozSax::Path.new @buffer
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
