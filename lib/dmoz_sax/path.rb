require 'delegate'

module DmozSax
  class Path < DelegateClass(Array)

    attr_reader :name, :level

    def initialize str, level = 0
      resource = str.gsub('_', ' ').split(':')

      @name = resource.first if resource.length == 2

      unless resource.empty?
        @path = resource.last.split('/').reject {|a| a =~ /^[A-Z]$/}
        @path.shift if 'Top' == @path.first
      else 
        @path = []
      end
      @level = level.to_i
      super(@path.freeze)
    end

    def to_a
      @path.dup
    end

    def to_s
      @path.join('/')
    end

    def parent_path
      if @path.length == 0
        nil
      else
        @path[0...-1].join('/')
      end
    end
  end
end
