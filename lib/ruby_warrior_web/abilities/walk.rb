module RubyWarriorWeb
  module Abilities
    class Walk < Base
      def description
        "Move in the given direction (forward by default)."
      end

      def perform(direction = :forward)
        event = {}

        verify_direction(direction)
        if @unit.position
          event.merge!(
            unit: @unit, action: :walk,
            direction: direction,
            from: serialize_position(@unit.position)
          )
          if space(direction).empty?
            from = @unit.position
            @unit.position.move(*offset(direction))
            event.merge!(to: serialize_position(@unit.position))
          else
            @unit.say "bumps into #{space(direction)}"
            event.merge!(result: :bump, space: space(direction))
          end
        end

        [event]
      end

      def serialize_position(position)
        [
          position.instance_variable_get(:@x),
          position.instance_variable_get(:@y)
        ]
      end
    end
  end
end
