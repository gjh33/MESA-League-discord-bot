require 'discord_league_bot/configuration'
require 'discordrb'
require 'rufus-scheduler'
require 'discord_league_bot/scheduled_events/monthly_lan'
require "discord_league_bot/version"
require 'discord_league_bot/commands/fun_commands'
require 'discord_league_bot/events/fun_events'
require 'discord_league_bot/raffle'
require 'discord_league_bot/commands/raffle_commands'

module DiscordLeagueBot
  def self.scheduler
    @scheduler ||= Rufus::Scheduler.new
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.raffle
    @raffle
  end

  def self.start_raffle!
    @raffle = Raffle.new
  end

  def self.clear_raffle!
    @raffle = nil
  end

  def self.configure
    yield configuration
  end

  def self.start
    # Create bot class
    bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_TOKEN'], client_id: ENV['DISCORD_CLIENT_ID'].to_i, prefix: '!'

    bot.include! Commands::FunCommands
    bot.include! Events::FunEvents
    bot.include! Commands::RaffleCommands

    # Basic ping command
    bot.command :ping do |event|
      "pong!"
    end

    bot.run :async

    # Set permission levels for users and roles
    configuration.administrators.each do |admin|
      bot.set_user_permission(admin, 999)
    end

    configuration.administrator_roles.each do |admin_role|
      bot.set_role_permission(admin_role, 999)
    end

    bot.servers.values.each do |server|
      bot.set_user_permission(server.owner.id, 999)
    end

    DiscordLeagueBot::ScheduledEvents::MonthlyLan.schedule(bot)

    bot.sync
    bot
  end
end
