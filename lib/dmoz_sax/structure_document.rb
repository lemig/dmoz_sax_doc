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
      @name = name
      @attributes = attributes

      case name
      when 'Topic'
        @path = Path.new attributes[0][1]
        @enrichments = {
            narrow: [],
            symbolic: [],
            related: [],
            alt_lang: [] }
      when 'Alias'
      when 'Target'
        @path = attributes[0][1]
      when 'altlang'
        @enrichments[:alt_lang] << DmozSax::Path.new(attributes[0][1])
      when 'related'
        @enrichments[:related] << DmozSax::Path.new(attributes[0][1])
      when /^narrow/
        @enrichments[:narrow] << [DmozSax::Path.new(attributes[0][1]), @name_parser.level_from(name)]
      when /^symbolic/
        @enrichments[:symbolic] << [DmozSax::Path.new(attributes[0][1]), @name_parser.level_from(name)]
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
      when 'lastUpdate'
        @time = @time_parser.time_from @buffer
      when 'Alias'
        if @on_alias
          @on_alias.call(@title, @path)
        end
      when 'Topic'
        if @on_topic
          @on_topic.call(@id, @path, @title, @description, @time, @enrichments)
        end
      end
    end
  end
end
