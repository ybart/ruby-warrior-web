
require "await"

module RubyWarriorWeb
  class Storage
    def self.load(kind, *components)
     if [:towers].include?(kind)
       load_from_vfs(kind, *components)
     else
       load_from_profile(*components)
     end
    end

    def self.save(filename, contents)
      `window.localStorage['#{filename}'] = "#{contents}"`
    end

    private

    def self.load_from_vfs(*components)
      path = components.join('/')
      `window.vfs[path]`
      # warn "TODO: Implement Storage#load_from_server(#{components.join('/')}) in JS proxy"
      # warn "TODO: Ruby implementation hardcodes beginner/level_001.rb"

      # File.read("public/storage/towers/beginner/level_001.rb")
    end

    def self.load_from_profile(*components)
      # TODO: JS
      warn "TODO: Implement Storage#load_from_profile(#{components.join('/')}) in JS proxy"
      "class Player; def play_turn(warrior); warrior.walk!; end; end"
    end
  end
end
