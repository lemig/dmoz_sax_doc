require 'delegate'

module DmozSax
  class Path < DelegateClass(Array)

    attr_reader :name

    def initialize str
      resource = str.gsub('_', ' ').split(':')
      @name = resource.first if resource.length == 2
      @path = resource.last.split('/').reject {|a| a =~ /^[A-Z]$/}
      @path.shift if 'Top' == @path.first
      super(@path.freeze)
    end

    def to_a
      @path.dup
    end

    def to_s
      @path.join('/')
    end
  end
end
