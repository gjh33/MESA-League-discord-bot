# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discord_league_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "discord_league_bot"
  spec.version       = DiscordLeagueBot::VERSION
  spec.authors       = ["Luke Jones"]
  spec.email         = ["manhappylife@yahoo.ca"]

  spec.summary       = %q{discord bot for matching discord users into league games}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
