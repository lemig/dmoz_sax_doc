module DmozSax
  class Topic
    attr_accessor :path, :cid, :narrows, :symbolics, :related, :alt_langs
    def initialize path_str
      @path = DmozSax::Path.new path_str
      @narrows, @symbolics, @related, @alt_langs = [], [], [], []
      @cid = nil
    end
  end
end
