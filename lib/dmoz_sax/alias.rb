module DmozSax
  class Alias
    attr_accessor :path
    def initialize path_str
      @path = DmozSax::Path.new path_str
    end
  end
end
