require "discord_league_bot/version"
require 'discordrb'

module DiscordLeagueBot
  def self.start
    bot = build_bot
    bot.run
  end

  def self.build_bot
    bot = Discordrb::Bot.new token: 'MzYwMTI0MjMyNzI3OTIwNjQw.DKRD4g._V36L5ISAfapo9T7sRf7sUx8jjk', client_id: 360124232727920640

    bot.message(with_text: "Ping!") do |event|
      event.respond("Pong!")
    end

    bot
  end
end
