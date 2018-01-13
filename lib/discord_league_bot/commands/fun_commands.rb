module DiscordLeagueBot
  module Commands
    module FunCommands
      extend Discordrb::Commands::CommandContainer

      command :random do |event|
        random = Random.new
        random.rand
      end

      command :dice, min_args: 0, max_args: 2, description: 'Generates a dice roll for a given number of dice of a given number of sides', usage: '!dice [number of sides] [number of dice]' do |event, sides, num_dice|
        # Load params and set defaults. Convert result to integer. Hurray for poorly typed languages!
        sides = (sides || 6).to_i
        num_dice = (num_dice || 1).to_i
        event << "Rolling #{num_dice == 1 ? 'a' : num_dice} #{sides}-sided dice..."
        random = Random.new
        rolls = []
        num_dice.times do
          rolls << random.rand(1..sides)
        end

        event << rolls.join(', ')
      end
    end
  end
end
