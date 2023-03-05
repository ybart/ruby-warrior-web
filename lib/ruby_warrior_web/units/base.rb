module RubyWarriorWeb
  module Units
    class Base < RubyWarrior::Units::Base
      def take_damage(amount)
        events = []
        unbind if bound?
        if health
          self.health -= amount

          events << {
            unit: self, kind: :damage,
            amount: amount, health: health
          }
          if health <= 0
            @position = nil
            events << { unit: self, kind: :death }
          end
        end

        events
      end

      def say(msg)
        # UI.puts_with_delay "#{name} #{msg}"
      end

      def add_abilities(*new_abilities)
        new_abilities.each do |ability|
          abilities[ability] = eval("Abilities::#{ability.to_s.sub('!', '').camelize}").new(self) # TODO use something similar to constantize here
        end
      end

      def perform_turn
        events = []

        if @position
          abilities.values.each do |ability|
            events += ability.pass_turn
          end
          if @current_turn.action && !bound?
            name, *args = @current_turn.action

            events += abilities[name].perform(*args)
          end
        end

        events
      end

      def play_turn
        # to be overriden by subclass
        []
      end
    end
  end
end
