module RubyWarriorWeb
  class LevelLoader < RubyWarrior::LevelLoader
    # this is override to use our Floar class
    def initialize(level)
      @floor = RubyWarriorWeb::Floor.new
      @level = level
      @level.floor = @floor
    end

    # ths is an override to use our warrior class
    def warrior(*args, &block)
      warn "DEBUG: RubyWarriorWeb::LevelLoader#warrior"
      @level.setup_warrior unit(Units::Warrior.new, *args, &block)
    end

    private

    # this is an override to use our Unit classes
    def unit_to_constant(name)
      camel = name.to_s.split('_').map { |s| s.capitalize }.join
      eval("Units::#{camel}")
    end
  end
end
