module DmozSax
  class Resource
    attr_reader :name, :path
    def initialize str
      
      arr = str.split ':'
      if arr.length == 2
        @name = arr[0]
        @path = Path.new arr[1]
      else
        @path = Path.new str
      end
    end

    def named?
      !(@name.nil? or @name.empty?)
    end
  end
end
