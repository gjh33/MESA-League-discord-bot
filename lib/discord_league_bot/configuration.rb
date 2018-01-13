module DiscordLeagueBot
  class Configuration
    attr_accessor :administrators
    attr_accessor :administrator_roles
    attr_accessor :lan_channels

    def initialize
      @administrators = []
      @administrator_roles = []
      @lan_channels = []
    end

    def admin id
      administrators << id unless administrators.include?(id)
    end

    def admin_role id
      administrator_roles << id unless administrator_roles.include?(id)
    end

    def lan_channel id
      lan_channels << id unless lan_channels.include?(id)
    end
  end
end
