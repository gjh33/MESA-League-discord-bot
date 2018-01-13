module DiscordLeagueBot
  module Events
    module FunEvents
      extend Discordrb::EventContainer

      message with_text: 'omae wa mou shindeiru' do |event|
        event.respond 'NANI!?!?!?!?!'
      end
    end
  end
end
