require 'discord_league_bot'

DiscordLeagueBot.configure do |config|
  # Add a role that is allowed to execute admin commands
  # config.admin_role <ROLE ID>
  config.admin_role 401437458098683904 #Administrator

  # Add a user that is allowed to execute admin commands
  # config.admin <USER ID>

  # Add a channel to receive notifications for regular LAN events
  #config.lan_channel <CHANNEL ID> #general
  config.lan_channel 239804973762871297 #general
end
