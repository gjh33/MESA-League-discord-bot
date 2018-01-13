module DiscordLeagueBot
  module ScheduledEvents
    module MonthlyLan
      def self.schedule bot
        # Initialize gateway code outside of scheduled jobs.
        # Jobs run in a thread without the active gateway so you can't
        # query inside them
        channels = []
        bot.servers.values.each do |server|
          channels += server.channels.select do |channel|
            DiscordLeagueBot.configuration.lan_channels.include?(channel.id)
          end
        end

        # Lan starting reminder
        #DiscordLeagueBot.scheduler.in '5s' do
        DiscordLeagueBot.scheduler.cron '0 7 * * fri' do
          return unless last_friday_of_month?

          DiscordLeagueBot.start_raffle!

          channels.each do |channel|
            bot.send_message(channel, "The LAN is now starting!", true)
            bot.send_message(channel, "The raffle for a mystery skin is now enabled. You can only win if you're online at 10pm EST when the results are drawn. Use the command `!raffle` to enter.")
          end
        end

        # Join the raffle reminder
        #DiscordLeagueBot.scheduler.in '10s' do
        DiscordLeagueBot.scheduler.cron '0 8,9 * * fri' do
          return unless last_friday_of_month?

          channels.each do |channel|
            bot.send_message(channel, "Don't forget to join the raffle before the end of the LAN! To join use the command `!raffle` and make sure you're online at 10pm EST.")
          end
        end

        # End the raffle
        #DiscordLeagueBot.scheduler.in '15s' do
        DiscordLeagueBot.scheduler.cron '0 10 * * fri' do
          return unless last_friday_of_month?
          return unless DiscordLeagueBot.raffle

          winner = DiscordLeagueBot.raffle.draw_random_contestant
          DiscordLeagueBot.clear_raffle!

          if winner
            channels.each do |channel|
              bot.send_message(channel, "The raffle results are in! Congratulations!", true)
              bot.send_message(channel, "The winner is #{ winner.mention }")
            end
          else
            channels.each do |channel|
              bot.send_message(channel, "The raffle ended with no contestants")
            end
          end
        end
      end

      def self.last_friday_of_month?
        last_friday = Date.new(Date.today.year, date.today.month, -1)
        last_friday -= (d.wday - 5) % 7
        return Date.today == last_friday
      end
    end
  end
end
