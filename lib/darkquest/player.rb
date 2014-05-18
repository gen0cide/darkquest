require 'sequel'
require 'digest/sha1'

module Darkquest
  class Player < ::Sequel::Model(:rsca2_players)
    set_primary_key :id

    def setup(user, owner, password)
      self.values.merge!(Constants::PLAYER_BASE.dup)
      self.values["user"] = Darkquest.encode_username(user)
      self.values["username"] = user
      self.values["pass"] = ::Digest::SHA1.hexdigest(password)
      self.values["creation_date"] = Time.now
      self.values["owner_username"] = owner
    end

    def add_character
      user = self.values[:user]
      Database.db[:rsca2_curstats].insert({
        user: user,
        cur_attack: 1,
        cur_defense: 1,
        cur_strength: 1,
        cur_hits: 10,
        cur_ranged: 1,
        cur_prayer: 1,
        cur_magic: 1,
        cur_cooking: 1,
        cur_woodcut: 1,
        cur_fletching: 1,
        cur_fishing: 1,
        cur_firemaking: 1,
        cur_crafting: 1,
        cur_smithing: 1,
        cur_mining: 1,
        cur_herblaw: 1,
        cur_agility: 1,
        cur_thieving: 1,
      })
      Database.db[:rsca2_experience].insert({
        user: user,
        exp_attack: 0,
        exp_defense: 0,
        exp_strength: 0,
        exp_hits: 1200,
        exp_ranged: 0,
        exp_prayer: 0,
        exp_magic: 0,
        exp_cooking: 0,
        exp_woodcut: 0,
        exp_fletching: 0,
        exp_fishing: 0,
        exp_firemaking: 0,
        exp_crafting: 0,
        exp_smithing: 0,
        exp_mining: 0,
        exp_herblaw: 0,
        exp_agility: 0,
        exp_thieving: 0,
      })
      Database.db[:rsca2_invitems].insert({
        user: user,
        id: 1263,
        amount: 1,
        wielded: 0,
        slot: 1
      })
      Database.db[:rsca2_invitems].insert({
        user: user,
        id: 10,
        amount: 100000,
        wielded: 0,
        slot: 0
      })
      Database.db[:rsca2_invitems].insert({
        user: user,
        id: 77,
        amount: 1,
        wielded: 0,
        slot: 2
      })     
    end       
  end
end