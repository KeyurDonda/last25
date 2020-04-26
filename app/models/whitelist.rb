class Whitelist < ActiveRecord::Base
  def self.is_whitelist(url)
    is_whitelist = false
    Whitelist.all.each do |whitelist|
      if url.include?(whitelist.url)
          is_whitelist = true
          return is_whitelist
      end
    end
    return is_whitelist
  end

end
