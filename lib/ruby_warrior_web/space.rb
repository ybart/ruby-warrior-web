module RubyWarriorWeb
  class Space < RubyWarrior::Space
    def warrior?
      unit.kind_of? Units::Warrior
    end

    # def golem?
    #   unit.kind_of? Units::Golem
    # end
  end
end
