module DmozSax
  class Alias
    attr_accessor :path
    def initialize path_str
      @path = DmozSax::Path.new path_str
    end

    def title
      @path.name
    end

    def title= str
      @path.name = str
    end
  end
end
