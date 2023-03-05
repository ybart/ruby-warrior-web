require 'opal'
require 'opal-browser'
require 'ruby_warrior'

def to_vfs(prefix, path)
  puts prefix + path
  Dir.glob(prefix + path)
     .filter { |name| File.file?(name) }
     .map { |name| [name.delete_prefix(prefix), File.read(name)] }
     .to_h
end

namespace :opal do
  desc "build the opal runtime with ruby-warrior in public/vendor/ruby-warrior.js"
  task :build do
    rubywarrior_spec = Bundler.definition.specs["rubywarrior"].first
    Opal.append_path './lib'
    Opal.append_path rubywarrior_spec.full_gem_path + "/lib"

    builder = Opal::Builder.new

    vfs = to_vfs(rubywarrior_spec.full_gem_path + '/', 'towers/**/*')
    builder.build("opal")
    builder.build("opal/full")
    builder.build("opal/parser")
    builder.build("opal/compiler")
    builder.build("opal-parser")
    builder.build("ruby_warrior_web")

    File.binwrite 'public/vendor/ruby_warrior.js',
                  builder.to_s + "window.vfs = #{vfs.to_json};"
  end
end
