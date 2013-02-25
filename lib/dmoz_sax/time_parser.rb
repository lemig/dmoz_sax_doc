module DmozSax
  class TimeParser
    def time_from string
      arr = string.split(/[-\s:]/).map(&:to_i)
      Time.utc(arr[0], arr[1], arr[2], arr[3], arr[4], arr[5])
    end
  end
end
