module DmozSax
  class NameParser
    def level_from name
      match = name.to_s.match(/^([A-Za-z_-]+)([\d]+)?$/)
      [match[1], match[2].to_i]
    end
  end
end
