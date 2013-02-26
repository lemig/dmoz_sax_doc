module DmozSax
  class Topic
    attr_accessor :path, :cid, :title, :description, :time,
        :narrows, :symbolics, :related, :alt_langs, :links
    def initialize path_str
      @path = DmozSax::Path.new path_str
      @narrows, @symbolics, @related, @alt_langs, @links = [], [], [], [], []
      @cid = nil
    end
  end
end
