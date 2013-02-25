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
      @attributes = attributes

      case name 
      when 'Topic'
        @path = DmozSax::Path.new attributes[0][1]
      when /^link/
        if @on_link
          @on_link.call(@name_parser.level_from(name), @id, @path, attributes[0][1]) 
        end
      when 'ExternalPage'
        @priority = 0
        @time = nil
        @url = attributes[0][1]
      end
    end

    def end_element name
    
      case name
      when 'catid'
        @id = @buffer.to_i
      when 'd:Description'
        @description = @buffer.strip
      when 'd:Title'
        @title = @buffer.strip.gsub('_', ' ')
      when 'topic'
        @path = DmozSax::Path.new @buffer
      when 'mediadate'
        @time = @time_parser.time_from @buffer
      when 'priority'
        @priority = @buffer.to_i
      when 'ExternalPage'
        if @on_external_page
          @on_external_page.call(@url, @title, @description, @path, @priority, @time)
        end
      end
    end
  end
end
