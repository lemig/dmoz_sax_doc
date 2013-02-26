module DmozSax
  class ExternalPage
    attr_accessor :url, :title, :description, :priority, :time
    def initializer url
      @url = url
      @title, @description = nil, nil
      @priority = 0
      @time = nil
    end
  end
end
