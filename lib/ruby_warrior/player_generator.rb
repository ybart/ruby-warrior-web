# This class is copied here to prevent the original file that requires
# rubygems and erb from loading as we do not wat these dependencies
# in our opal build.

module RubyWarrior
  class PlayerGenerator
    def initialize(level)
      @level = level
    end

    def level
      @level
    end

    def previous_level
      @previous_level ||= Level.new(level.profile, level.number-1)
    end

    # TODO refactor and test this method
    def generate
      if level.number == 1
        FileUtils.mkdir_p(level.player_path) unless File.exists? level.player_path
        FileUtils.cp(templates_path + '/player.rb', level.player_path)
      end

      File.open(level.player_path + '/README', 'w') do |f|
        f.write read_template(templates_path + '/README.erb')
      end
    end

    def templates_path
      File.expand_path("../../../templates", __FILE__)
    end

    private

    def read_template(path)
      ERB.new(File.read(path), nil, '-').result(binding)
    end
  end
end
