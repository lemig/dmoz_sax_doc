require 'nokogiri'

module DmozSax
  class StructureDocument < Nokogiri::XML::SAX::Document

    attr_accessor :on_topic, :on_alias
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

      case name
      when 'Topic'
        @cid, @description, @title = nil, nil, nil
        @topic = DmozSax::Topic.new attributes[0][1]
      when 'Alias'
        @alias = DmozSax::Alias.new attributes[0][1]
      when 'Target'
        @path = attributes[0][1]
      when 'altlang'
        @topic.alt_langs << DmozSax::Path.new(attributes[0][1])
      when 'related'
        @topic.related << DmozSax::Path.new(attributes[0][1])
      when /^narrow/
        @topic.narrows << DmozSax::Path.new(attributes[0][1], @name_parser.level_from(name))
      when /^symbolic/
        @topic.symbolics << DmozSax::Path.new(attributes[0][1], @name_parser.level_from(name))
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
      when 'lastUpdate'
        @time = @time_parser.time_from @buffer
      when 'Alias'
        @alias.title = @title
        @on_alias.call(@alias) unless @on_alias.nil?
      when 'Topic'
        @topic.cid = @cid
        @topic.title = @title
        @topic.description = @description
        @topic.time = @time
        @on_topic.call(@topic) unless @on_topic.nil?
      end
    end
  end
end
