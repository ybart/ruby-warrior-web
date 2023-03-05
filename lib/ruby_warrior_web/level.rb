module RubyWarriorWeb
  class Level < RubyWarrior::Level
    def load_level
      data = Storage.load(
        :towers, @profile.tower_path, "level_00#{number}.rb"
      )
      LevelLoader.new(self).instance_eval(data)
    end

    def load_player
      data = Storage.load(:profile, 'player.rb')
      eval data, TOPLEVEL_BINDING
    end

    # override to use our class instead of original
    def generate_player_files
      load_level
      PlayerGenerator.new(self).generate
    end

    def play(turns = 1000)
      load_level
      report = { turns: [{turn: 0, floor_map: @floor.character}] }
      turns.times do |n|
        return report if passed? || failed?
        turn_data = { turn: n+1, events: [] }

        @floor.units.each { |unit| turn_data[:events] += unit.prepare_turn }
        @floor.units.each { |unit| turn_data[:events] += unit.perform_turn }

        @time_bonus -= 1 if @time_bonus > 0
        report[:turns] << turn_data.merge(floor_map: @floor.character)
      end
      report
    end
  end
end
