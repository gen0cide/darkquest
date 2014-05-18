require 'sequel'
require 'uri'
require 'mysql2'

module Darkquest
  class Database

    @@db = Sequel::Database.new

    def self.connect(username, password, host, port, name)
      @@db = Sequel.connect("mysql2://#{username}:#{URI.encode(password)}@#{host}:#{port}/#{name}")
      Player.db = @@db 
    end

    def self.db
      @@db
    end

    def self.top_five_by_skill(skill,limit=5)
      return nil unless Darkquest.valid_skill?(skill)
      results = @@db["SELECT rsca2_experience.exp_#{skill} AS xp, rsca2_players.username FROM rsca2_experience, rsca2_players WHERE (rsca2_experience.user = rsca2_players.user) ORDER BY exp_#{skill} DESC LIMIT #{limit}"]
      return results
    end
  end
end