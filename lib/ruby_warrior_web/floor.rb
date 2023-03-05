module RubyWarriorWeb
  class Floor < RubyWarrior::Floor
    # this is an override to use our Warrior class
    def other_units
      units.reject { |u| u.kind_of? Units::Warrior }
    end

    def space(x, y)
      Space.new(self, x, y)
    end

    def character
      super

      # TODO: If the map alone is not enough to display a proper
      #       map (for instance, we might miss character directions),
      #       we will need to implement this method so it returns an
      #       2D array with objects when string is not enough.
    end
  end
end
