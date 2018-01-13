module DiscordLeagueBot
  class Raffle
    def initialize
      @contestants_hash = {}
    end

    def enter_user user
      return false if @contestants_hash.include?(user.distinct)
      @contestants_hash[user.distinct] = user
      true
    end

    def draw_random_contestant
      @contestants_hash[@contestants_hash.keys.sample]
    end

    def reset
      @contestants_hash = {}
    end
  end
end
