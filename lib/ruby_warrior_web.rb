require "ruby_warrior_web/version"
require "ruby_warrior"

module RubyWarriorWeb
  class Engine
    def self.build_profile(tower, name)
      Profile.new.tap do |profile|
        profile.tower_path = tower
        profile.warrior_name = name
        prepare_next_level(profile)
      end
    end

    def self.prepare_next_level(profile)
      next_level = profile.next_level
      next_level.generate_player_files
      profile.level_number += 1
      profile.save
    end

    def self.play(profile)
      current_level = profile.current_level
      current_level.load_player
      current_level.play.merge(
        passed: current_level.passed?,
        finished: (current_level.number == 9)
      ).tap do |data|
        if data[:passed] && !data[:finished]
          prepare_next_level(profile)
        end
      end
    end
  end
end

require_relative 'ruby_warrior_web/profile.rb'
require_relative 'ruby_warrior_web/level.rb'
require_relative 'ruby_warrior_web/storage.rb'
require_relative 'ruby_warrior_web/level_loader.rb'
require_relative 'ruby_warrior_web/floor.rb'
require_relative 'ruby_warrior_web/space.rb'
require_relative 'ruby_warrior_web/player_generator.rb'
require_relative 'ruby_warrior_web/units/base.rb'
require_relative 'ruby_warrior_web/units/warrior.rb'
require_relative 'ruby_warrior_web/abilities/base.rb'
require_relative 'ruby_warrior_web/abilities/walk.rb'
