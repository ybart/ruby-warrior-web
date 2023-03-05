module RubyWarriorWeb
  module Abilities
    class Base < RubyWarrior::Abilities::Base
      def damage(receiver, amount)
        receiver.take_damage(amount).merge(
          receiver.alive? ? {} : @unit.earn_points(receiver.max_health)
        )
      end

      def pass_turn
        # callback which is triggered every turn
        []
      end
    end
  end
end
