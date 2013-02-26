module DmozSax
  class Alias
    attr_accessor :path, :title
    def initialize path_str
      @path = DmozSax::Path.new path_str
      @title = @path.name
    end
  end
end
