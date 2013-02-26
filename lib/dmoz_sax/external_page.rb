module DmozSax
  class ExternalPage
    attr_accessor :url, :path, :title, :description, :priority, :time
    def initialize url
      @url = url
      @path, @title, @description = nil, nil, nil
      @priority = 0
      @time = nil
    end
  end
end
