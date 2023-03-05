module RubyWarriorWeb
  class PlayerGenerator < RubyWarrior::PlayerGenerator
    def generate
      if level.number == 1
        player_template = Storage.load(:templates, 'player.rb')
        Storage.save('player.rb', player_template)
      end

      units_data = level.floor.unique_units.map do |unit|
        {
          character: unit.character,
          name: unit.name,
          max_health: unit.max_health
        }
      end

      abilities_data = level.warrior.abilities.each do |name, ability|
        {
          name: "warrior.#{name}",
          description: ability.description
        }
      end

      #golem_abilities = level.warrior.base_golem.abilities
      #golem_abilities_data = golem_abilities.each do |name, ability|
      #  {
      #    name: "golem.#{name}",
      #    description: ability.description
      #  }
      #end

      readme_data = {
        level: level.number,
        description: level.description,
        tip: level.tip,
        character: level.floor.character,
        units: units_data,
        abilities: abilities_data,
        #golem_abilities: golem_abilities_data
      }
    end
  end
end
