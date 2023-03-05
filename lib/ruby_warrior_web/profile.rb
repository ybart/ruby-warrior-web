module RubyWarriorWeb
  class Profile < RubyWarrior::Profile
    def self.load(path)
      decode(Storage.load(:profile, '.profile'))
    end

    def tower
      Tower.new(File.basename @tower_path)
    end
    
    def current_level
      Level.new(self, level_number)
    end
    
    def next_level
      Level.new(self, level_number+1)
    end

    def save
      update_epic_score
      @level_number = 0 if epic?

      Storage.save('.profile', encode)
    end
  end
end
