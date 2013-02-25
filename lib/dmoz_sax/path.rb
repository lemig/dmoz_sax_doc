require 'delegate'

module DmozSax
  class Path < DelegateClass(Array)

    def initialize str
      @path = str.gsub('_', ' ').split('/').reject {|a| a =~ /^[A-Z]$/}
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
