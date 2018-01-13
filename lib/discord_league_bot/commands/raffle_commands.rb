module DiscordLeagueBot
  module Commands
    module RaffleCommands
      extend Discordrb::Commands::CommandContainer

      command :raffle do |event|
        if !DiscordLeagueBot.raffle
          "There is currently no active raffle."
        elsif DiscordLeagueBot.raffle.enter_user event.user
          "#{event.user.name} has joined the raffle."
        else
          "#{event.user.name}, you've already entered the raffle!"
        end
      end

      command :draw_raffle, permission_level: 999 do |event|
        winner = DiscordLeagueBot.raffle.draw_random_contestant
        DiscordLeagueBot.clear_raffle!
        if winner
          event << "The raffle results are in! Congratulations!"
          event << "The winner is #{ winner.mention }"
        else
          "The raffle ended with no contestants"
        end
      end

      command :cancel_raffle, permission_level: 999 do |event|
        DiscordLeagueBot.clear_raffle!
        "Raffle canceled."
      end

      command :start_raffle, permission_level: 999 do |event|
        DiscordLeagueBot.start_raffle!
        "The raffle has begun! Use command `!raffle` to enter."
      end
    end
  end
end
