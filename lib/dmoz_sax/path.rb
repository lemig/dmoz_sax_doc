require 'delegate'

module DmozSax
  class Path < DelegateClass(Array)

    attr_reader :name, :level

    def initialize str, level = 0
      resource = str.gsub('_', ' ').split(':')

      @name = resource.first if resource.length == 2
      @level = level.to_i

      unless resource.empty?
        super(resource.last.split('/'))
      else
        super([])
      end
    end

    def to_s
      DmozSax::Path.path_str(DmozSax::Path.normalize(self))
    end

    def parent_to_s
      DmozSax::Path.path_str(DmozSax::Path.normalize(self[0...-1]))
    end

    def self.path_str arr
      arr.empty? ? '/' : "/#{ arr.join('/') }"
    end

    def self.normalize arr
      if arr.nil? or arr.length == 0
        []
      else
        dup = arr.dup.reject {|a| a =~ /^[A-Z0-9]$/}
        dup.shift if arr.first == 'Top'
        dup
      end
    end
  end
end
