require "darkquest/version"
require "darkquest/constants"
require "darkquest/database"
require "darkquest/player"
require "sequel"
require "mysql2"

module Darkquest
  def self.xp_to_level(xp)
    99.times do |x|
      if xp >= Constants::LEVELS[x]
        next;
      end
      return (x+1)
    end
    return 99
  end

  def self.valid_skill?(string)
    return Constants::SKILLS.include?(string)
  end

  def self.encode_username(string)
    base = string.dup
    base.downcase!
    new_base = ""
    i = 0
    base.length.times do
      c = base[i]
      if (c >= 'a' && c <= 'z')
        new_base += c
      elsif (c >= '0' and c <= '9')
        new_base += c
      else
        new_base += ' '
      end
      i += 1
    end
    new_base.strip!
    if new_base.length > 12
      new_base = new_base[0..12]
    end
    int = 0
    i = 0
    new_base.length.times do 
      c = new_base[i]
      int *= 37
      if (c >= 'a' && c <= 'z')
        int += ((1 + c.bytes[0]) - 97)
      elsif (c >= '0' && c <= '9')
        int += ((27 + c.bytes[0]) - 48)
      end
      i += 1
    end
    return int
  end

  def self.decode_username(long)
    return nil if long =~ /^\d+$/
    value = nil
    begin
      value = Integer(long)
    rescue
      return nil
    end
    string = ""
    while value != 0
      i = value % 37
      value /= 37
      if i == 0
        string = " " + string
      elsif i < 27
        if value % 37 == 0
          string = ((i + 65) - 1).chr + string
        else
          string = ((i + 97) - 1).chr + string
        end
      else
        string = ((i + 48) - 27).chr + string
      end
    end
    return string
  end
end
